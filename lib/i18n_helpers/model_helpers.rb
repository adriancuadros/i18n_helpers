module I18nHelpers
  module ModelHelpers
  
    def self.included(base)
      base.send :include, InstanceMethods
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
         I18n.t(err_name.to_s, :scope => [:activerecord, :errors, model_name.downcase.to_sym, :attributes] << scope)
      end
    end
  end
end

ActiveRecord::Base.send :include, I18nHelpers::ModelHelpers