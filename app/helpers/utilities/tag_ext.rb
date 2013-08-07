module RecurringSelectHelper
  module SelectHTMLOptions
    private

    def recurring_select_html_options(html_options)
      html_options = html_options.stringify_keys
      html_options["class"] = (html_options["class"].to_s.split + ["recurring_select"]).join(" ")
      html_options
    end
  end

  if Rails::VERSION::STRING.to_f >= 4.0
    # === Rails 4
    class RecurringSelectTag < ActionView::Helpers::Tags::Base
      include RecurringSelectHelper::FormOptionsHelper
      include SelectHTMLOptions

      def initialize(object, method, template_object, default_schedules = nil, options = {}, html_options = {})
        @default_schedules = default_schedules
        @choices = @choices.to_a if @choices.is_a?(Range)
        @method_name = method.to_s
        @object_name = object.to_s
        @html_options = recurring_select_html_options(html_options)
        add_default_name_and_id(@html_options)

        super(object, method, template_object, options)
      end

      def render
        option_tags = add_options(recurring_options_for_select(value(object), @default_schedules, @options), @options, value(object))
        select_content_tag(option_tags, @options, @html_options)
      end
    end

  else
    # === Rails 3
    class InstanceTag < ActionView::Helpers::InstanceTag
      include RecurringSelectHelper::FormOptionsHelper
      include SelectHTMLOptions

      def to_recurring_select_tag(default_schedules, options, html_options)
        html_options = recurring_select_html_options(html_options)
        add_default_name_and_id(html_options)
        value = value(object)
        options = add_options(
          recurring_options_for_select(value, default_schedules, options),
          options, value
        )
        content_tag("select", options, html_options)
      end
    end
  end
end
