require "ice_cube"
require_relative "utilities/form_options_ext"
require_relative "utilities/tag_ext"

module RecurringSelectHelper
  module FormHelper
    def select_recurring(object, method, default_schedules = nil, options = {}, html_options = {})
      if Rails::VERSION::STRING.to_f >= 4.0
        # === Rails 4
        RecurringSelectTag.new(object, method, self, default_schedules, options, html_options).render
      else
        # === Rails 3
        InstanceTag.new(object, method, self, options.delete(:object)).to_recurring_select_tag(default_schedules, options, html_options)
      end
    end
  end

  module FormBuilder
    def select_recurring(method, default_schedules = nil, options = {}, html_options = {})
      if !@template.respond_to?(:select_recurring)
        @template.class.send(:include, RecurringSelectHelper::FormHelper)
      end

      @template.select_recurring(@object_name, method, default_schedules, options.merge(:object => @object), html_options)
    end
  end
end
