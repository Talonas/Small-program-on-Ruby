class MainMethod
  
  def prepare_for_save
    attr_array = []
      
    self.instance_variables.each { |attribute| attr_array += [attribute] }
    id_position = attr_array.index("@id")
    if id_position
      attr_array.delete_at(id_position)
    end
      
    hash = {}
    attr_array.each do |attribute|
      hash[attribute.to_s.tr_s("@", "")] = self.instance_variable_get(attribute)
    end
    
    hash
  end
  
  def before_save
    true
  end
 
  def save
    if before_save
      if @id == nil
        ActiveRecord.save(self.class.to_s, prepare_for_save)
      else
        ActiveRecord.update(self.class.to_s, @id, prepare_for_save)
      end
      return true
    end
    false
  end
  
end