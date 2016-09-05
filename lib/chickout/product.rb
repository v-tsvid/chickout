module Product
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def title_by_id(id)
      find_by_id(id).try(:title)
    end
  end
end
