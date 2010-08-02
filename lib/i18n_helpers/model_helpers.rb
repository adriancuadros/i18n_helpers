module I18nHelpers
  module ModelHelpers
  
    def self.included(base)
      base.send :include, InstanceMethods
      base.send :extend, ClassMethods
    end
    
    module ClassMethods
      def attr_name(att_name)
        I18n.t(att_name.to_s, :scope => [:activerecord, :attributes, self.name.downcase])
      end
    end
    
    module InstanceMethods
      def local_errors()
        errors = { }
        self.errors.each do |a, e|
          if errors[self.class.attr_name(a)].nil?
            errors[self.class.attr_name(a)] = e
          else
            errors[self.class.attr_name(a)] = [errors[self.class.attr_name(a)], e].join(', ')
          end
        end
        errors
      end
      
      def err(err_name,scope=[])
         I18n.t(err_name.to_s, :scope => [:activerecord, :errors, self.class.to_s.downcase.to_sym, :attributes] << scope)
      end
    end
  end
end

ActiveRecord::Base.send :include, I18nHelpers::ModelHelpers