class SampleController < ApplicationController
  
  def index
    ActionView::Helpers::FormHelper.send(:include, RecurringSelect::Helpers::FormHelper)
    ActionView::Helpers::FormOptionsHelper.send(:include, RecurringSelect::Helpers::FormOptionsHelper)
    ActionView::Helpers::FormBuilder.send(:include, RecurringSelect::Helpers::FormBuilder)
  end
  
end
