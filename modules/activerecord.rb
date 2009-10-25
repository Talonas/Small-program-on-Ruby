require 'rubygems'
require 'sqlite3'

module ActiveRecord
  
  @data_base = "data.db"
  @db = SQLite3::Database.new(@data_base)
  @db.results_as_hash = true
  
  def ActiveRecord.build_object(table, row_hash)
    new_object = eval(table.chop).new()
    instances = new_object.instance_variables
    row_hash.each do |row|
      attr_name = "@#{row[0]}"
      if instances.index(attr_name) != nil
        new_object.instance_variable_set(instances[instances.index(attr_name)], row[1])
      end
    end
    return new_object
  end
  
  def ActiveRecord.find(class_name, query)
    class_name += "s"
    
    if !query.is_a? Hash
      @db.execute("SELECT * FROM #{class_name} WHERE id = '#{query}'") { |row| return build_object(class_name, row) }
    end
    
  end
  
end