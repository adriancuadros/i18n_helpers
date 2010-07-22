module I18nHelpers
  module ControllerAndViewHelpers

    def self.included(base)
      base.send :include,  InstanceMethods
    end
  
    module InstanceMethods
      def txt(t_name, params={})
        section = params[:section] || controller_name.singularize
        section.gsub!('create', 'new') && section.gsub!('update', 'edit')
        scope = [] << params[:scope] if params[:scope]
        I18n.t(t_name, :scope => [:text, section.to_sym, action_name] << scope)
      end

      def att(att_name, object=nil)
        I18n.t(att_name.to_s, :scope => [:activerecord,:attributes, object||controller_name.singularize])
      end
  
      def apt(att_name, scope=[])
        I18n.t(att_name, :scope => [:text, :application] << scope)
      end
  
      def lbl(lbl_name,scope=[])
         I18n.t(t.to_s, :scope => [:helpers, :label, controller_name.singularize] << scope)
      end
    end
  end
end

ActionView::Base.send :include, I18nHelpers::ControllerAndViewHelpers