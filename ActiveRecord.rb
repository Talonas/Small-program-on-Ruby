require 'rubygems'
require 'sqlite3'

require 'artist'

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
    
    if (query.is_a?(Fixnum) || /^[\d]+(\.[\d]+){0,1}$/===query)
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
     
    if query.is_a?(Hash)
      query_data = []
      query.each { |value| query_data += ["#{value[0]} = '#{value[1]}'"] }
      @db.execute("SELECT * FROM #{class_name} WHERE #{query_data.join(' AND ')}") do |row|
        list += [build_object(class_name, row)]
      end
      return list.empty? ? false : list
    end
    
    if query == false
      @db.execute("SELECT * FROM #{class_name}") { |row| list += [build_object(class_name, row)] }
      return list.empty? ? false : list
    end

    return false
  end
  
  def ActiveRecord.save(class_name, query)
    class_name += "s"
    columns = []
    values  = []
    query.each do |value|
      columns += [value[0]]
      values  += ["'#{value[1]}'"]
    end
    @db.execute("INSERT into #{class_name} (#{columns.join(', ')}) VALUES (#{values.join(', ')})")
  end
  
  def ActiveRecord.update(class_name, query)
    class_name += "s"
    update_values = []
    query.each do |value|
      update_values += ["#{value[0]} = '#{value[1]}'"]   
    end
    
    @db.execute("UPDATE #{class_name} SET #{update_values.join(' ,')} WHERE id='#{id}'")       
  end
  
end