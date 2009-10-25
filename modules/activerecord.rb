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
  
  def ActiveRecord.generate_sql_sentence hash
    sql_sentence = ""
    
    hash.each do |query|
      sql_sentence += " #{query[0]} "
      
      if query[1].is_a? Hash
        query_params = []
        query[1].each { |parameter| query_params += ["#{parameter[0]} = '#{parameter[1]}'"] }  
        sql_sentence += query_params.join(" AND ")
      else
        sql_sentence += " #{query[1]} "
      end
    end
    
    return sql_sentence
  end
  
  def ActiveRecord.find(class_name, query)
    class_name += "s"
    
    if !query.is_a? Hash
      @db.execute("SELECT * FROM #{class_name} WHERE id = '#{query}'") { |row| return build_object(class_name, row) }
    end
    
    if query.is_a? Hash
      sql_sentence = ActiveRecord.generate_sql_sentence query
      @db.execute("SELECT * FROM #{class_name} #{sql_sentence}") { |row| return build_object(class_name, row) }
    end
    
    return false
    
  end
  
  def ActiveRecord.find_all(class_name, query=false)
    class_name += "s"
    object_list = []
      
    if !query
      @db.execute("SELECT * FROM #{class_name}") { |row| object_list += [build_object(class_name, row)] }
      return !object_list.empty? ? object_list : false
    end
    
    if query.is_a? Hash
      sql_sentence = ActiveRecord.generate_sql_sentence query
      @db.execute("SELECT * FROM #{class_name} #{sql_sentence}") { |row| object_list += [build_object(class_name, row)] }
      return !object_list.empty? ? object_list : false
    end
    
    return false
    
  end
  
end