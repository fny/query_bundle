require 'active_record'
require 'query_bundle/version'

class QueryBundle
  attr_reader :mappings

  NotExecutedError = Class.new(StandardError)

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
    sql = relations_sql
    pg_results = []

    log(sql) do
      conn.get_last_result
      conn.send_query(sql)
      conn.block
      while pg_result = conn.get_result
        pg_results << pg_result
      end
    end

    mappings.each_with_index do |label_mapping, i|
      label, mapping = label_mapping
      pg_result = pg_results[i]
      model = mappings[label][:model]
      mappings[label][:results] = convert_to_records(pg_result, model)
    end
    true
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
    ActiveRecord::Base.connection.raw_connection
  end

  def log(*args, &block)
    ActiveRecord::Base.connection.send(:log, *args, &block)
  end

  def convert_to_records(pg_result, model)
    fields = pg_result.fields
    pg_result.values.map { |value_set|
      model.new(model_params(fields, value_set))
    }
  end

  def relations_sql
    mappings.map { |label, mapping| mapping[:sql] }.join(';')
  end

  def model_params(fields, values)
    adjust_timestamps(Hash[fields.zip(values)])
  end

  # Timestamps are not converted properly from UTC if active record's
  # default_time_zone is set to :local
  def adjust_timestamps(params)
    timestamp_columns.each do |col|
      params[col] += ' UTC' if params.has_key?(col)
    end
    params
  end

  def timestamp_columns
    ['created_at', 'updated_at']
  end
end
