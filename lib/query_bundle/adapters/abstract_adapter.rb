class QueryBundle
  class AbstractAdapter
    private

    def sql_for(arels, binds)
      arels.zip(binds).map { |arel, bind| to_sql(arel, bind.try(:dup)) }.join(';')
    end

    def log(*args, &block)
      ActiveRecord::Base.connection.send(:log, *args, &block)
    end

    def conn
      # Guarantees separate PG::Connection per thread
      ActiveRecord::Base.connection.raw_connection
    end
  end
end
