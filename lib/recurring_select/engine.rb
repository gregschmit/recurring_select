require File.expand_path("formbuilder_extensions", File.dirname(__FILE__))

module RecurringSelect
  class Engine < Rails::Engine
    
    # merge RecurringSelectHelper into ActionView
    initializer "recurring_select.extend_form_builder" do |app|
      ActionView::Helpers::FormHelper.send(:include, RecurringSelect::Helpers::FormHelper)
      ActionView::Helpers::FormOptionsHelper.send(:include, RecurringSelect::Helpers::FormOptionsHelper)
      ActionView::Helpers::FormBuilder.send(:include, RecurringSelect::Helpers::FormBuilder)
    end
    
  end
end
