# lib/active_record/add_reset_pk_sequence_to_base.rb
module ActiveRecord
  class Base
    def self.reset_pk_sequence
      case ActiveRecord::Base.connection.adapter_name
      when 'SQLite'
        new_max = maximum(primary_key) || 0
        update_seq_sql = "update sqlite_sequence set seq = #{new_max} where name = '#{table_name}';"
        ActiveRecord::Base.connection.execute(update_seq_sql)
      when 'PostgreSQL'
        ActiveRecord::Base.connection.reset_pk_sequence!(table_name)
      else
        raise "Task not implemented for this DB adapter"
      end
    end     
  end
end

# Usage
# Client.count # 3
# Client.destroy_all
# Client.reset_pk_sequence
# Client.create(:name => 'Sam') # this client will have id=1