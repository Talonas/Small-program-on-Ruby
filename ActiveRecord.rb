require 'rubygems'
require 'sqlite3'

require 'artist'

module ActiveRecord
  
  @data_base = "data.db"
  @db = SQLite3::Database.new(@data_base)
  
  def ActiveRecord.build_object(table, row)
    new_object = eval(table.chop).new()    
    instances = new_object.instance_variables    
    i = 0
    row.each do |value|
      new_object.instance_variable_set(instances[i], value)
      i += 1
    end  
    return new_object
  end
  
end