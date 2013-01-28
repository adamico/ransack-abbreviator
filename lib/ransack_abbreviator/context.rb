module Ransack
  class Context
    alias_method :is_ransackable_attribute?, :ransackable_attribute?
    alias_method :ransack_bind, :bind
    
    def bind(object, str)
      binding.pry
      ransack_bind(object, str)
    end

    def ransackable_attribute?(str, klass)
      binding.pry
      is_ransackable_attribute?(str, klass) || str == "nm"
    end
  end
  
  module Adapters
    module ActiveRecord
      class Context
        alias_method :ransack_type_for, :type_for

        def type_for(attr)
          ransack_type_for(attr)
          binding.pry
        end
      end
    end
  end
  
  module Nodes
    class Attribute
      alias_method :ransack_name=, :name=
      alias_method :ransack_attr_name=, :attr_name=
      alias_method :ransack_initialize, :initialize
      
      def initialize(context, name = nil)
        super(context)
        self.name = name unless name.blank?
      end
      
      def name=(name)
        binding.pry
        # Jamie: Here. name was "children_nm"
        name = "name" if name == "nm"
        self.ransack_name = name
      end
      
      def attr_name=(attr_name)
        binding.pry
        attr_name = "name" if attr_name == "nm"
        self.ransack_attr_name = attr_name
      end
    end
  end
end