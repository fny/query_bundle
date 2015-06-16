class QueryBundle
  module Adapters
    class PostgreSQLAdapter
      def execute(arels, binds, name)
        sql = sql_for(arels, binds)
        binds = binds.flatten(1).compact

        log(sql, name, binds) do
          if binds.empty?
            # Clear the queue
            conn.get_last_result
            conn.send_query(sql)
            conn.block
            conn.get_result
          else
            # Clear the queue
            conn.get_last_result
            conn.send_query(sql, binds.map { |col, val|
              conn.type_cast(val, col)
            })
            conn.block
            conn.get_result
          end
        end
      end


      def execute_query(sql)

      end
    end
  end
end
