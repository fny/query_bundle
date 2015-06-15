require 'active_record'
require 'query_bundle/version'

class QueryBundle
  attr_reader :mappings

  NotExecutedError = Class.new(StandardError)

  def self.connection
    @connection ||=
      ActiveRecord::Base.connection.instance_variable_get(:@connection)
  end

  def self.fetch(mappings = {})
    bundle = new(mappings)
    bundle.execute
    bundle
  end

  def initialize(mappings = {})
    @mappings = {}
    @executed = false
    mappings.each { |label, relation| add(label, relation) }
  end

  # Private for now...
  def add(label, relation)
    mappings[label] = { model: relation.model, sql: relation.to_sql }
  end

  def execute
    @executed = true
    conn.get_last_result
    conn.send_query(relations_sql)
    conn.block
    pg_results = []
    while pg_result = conn.get_result
      pg_results << pg_result
    end

    mappings.each_with_index do |label_mapping, i|
      label, mapping = label_mapping
      pg_result = pg_results[i]
      model = mappings[label][:model]
      mappings[label][:results] = convert_to_records(pg_result, model)
    end
  end

  def executed?
    @executed
  end

  def method_missing(method, *args, &block)
    if !executed?
      fail(NotExecutedError, "you need to call #execute on the bundle first")
    else
       fetch_results(method) || super(method, *args, &block)
    end
  end

  private

  def fetch_results(label)
    return nil unless mappings.has_key?(label)
    mappings[label][:results] || []
  end

  def conn
    QueryBundle.connection
  end

  def convert_to_records(pg_result, model)
    fields = pg_result.fields
    pg_result.values.map { |value_set|
      model.new(Hash[fields.zip(value_set)])
    }
  end

  def relations_sql
    mappings.map { |label, mapping| mapping[:sql] }.join(';')
  end
end
