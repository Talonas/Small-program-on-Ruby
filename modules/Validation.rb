module Validation
  
  def Validation.not_empty(value)
    if value.is_a? NilClass
      return false
    end
    if value.empty? 
      return false
    end
    return true
  end
  
  def Validation.is_numeric(value)
    if value.is_a? NilClass
      return false
    end
    if value.is_a?(Fixnum)
      return true
    end
    if value.is_a?(String)
      return /^[\d]+(\.[\d]+){0,1}$/ === value
    end
    false
  end
  
end