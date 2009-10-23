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
  
  def ActiveRecord.find(class_name, query)
    class_name += "s"
    
    if query.is_a?(Fixnum)
      @db.execute("SELECT * FROM #{class_name} WHERE id = '#{query}'") do |row|
        return build_object(class_name, row)
      end
    end
    
    if query.is_a?(Hash)
      query_data = []
      query.each { |value| query_data += ["#{value[0]} = '#{value[1]}'"] }
      @db.execute("SELECT * FROM #{class_name} WHERE #{query_data.join(' AND ')}") do |row|
        return build_object(class_name, row)
      end
    end
    
    return false
  end
  
  def ActiveRecord.find_all(class_name, query=false)
    class_name += "s"
    list = []
    
    if !query
      @db.execute("SELECT * FROM #{class_name}") { |row| list += [build_object(class_name, row)] }
    end
     
    
    return list
  end
  
end