require "ice_cube"

module RecurringSelectHelper
  module FormHelper
    if Rails::VERSION::MAJOR >= 4
      def select_recurring(object, method, default_schedules = nil, options = {}, html_options = {})
        RecurringSelectTag.new(object, method, self, default_schedules, options, html_options).render
      end
    elsif Rails::VERSION::MAJOR == 3
      def select_recurring(object, method, default_schedules = nil, options = {}, html_options = {})
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

  module FormOptionsHelper
    def recurring_options_for_select(currently_selected_rule = nil, default_schedules = nil, options = {})

      options_array = []
      blank_option_label = options[:blank_label] || I18n.t("recurring_select.not_recurring")
      blank_option = [blank_option_label, "null"]
      separator = [I18n.t("recurring_select.or"), {:disabled => true}]

      if default_schedules.blank?
        if currently_selected_rule.present?
          options_array << ice_cube_rule_to_option(currently_selected_rule)
          options_array << separator
          options_array << [I18n.t("recurring_select.change_schedule"), "custom"]
          options_array << blank_option if options[:allow_blank]
        else
          options_array << blank_option
          options_array << [I18n.t("recurring_select.set_schedule"), "custom"]
        end
      else
        options_array << blank_option if options[:allow_blank]

        options_array += default_schedules.collect{|dc|
          ice_cube_rule_to_option(dc)
        }

        if currently_selected_rule.present? and !current_rule_in_defaults?(currently_selected_rule, default_schedules)
          options_array << ice_cube_rule_to_option(currently_selected_rule, true)
          custom_label = [I18n.t("recurring_select.new_custom_schedule"), "custom"]
        else
          custom_label = [I18n.t("recurring_select.custom_schedule"), "custom"]
        end

        options_array << separator
        options_array << custom_label
      end

      options_for_select(options_array, currently_selected_rule.to_json)
    end

    private

    def ice_cube_rule_to_option(supplied_rule, custom = false)
      return supplied_rule unless RecurringSelect.is_valid_rule?(supplied_rule)

      rule = RecurringSelect.dirty_hash_to_rule(supplied_rule)
      ar = [rule.to_s, rule.to_hash.to_json]

      if custom
        ar[0] << "*"
        ar << {"data-custom" => true}
      end

      ar
    end

    def current_rule_in_defaults?(currently_selected_rule, default_schedules)
      default_schedules.any?{|option|
        option == currently_selected_rule or
          (option.is_a?(Array) and option[1] == currently_selected_rule)
      }
    end
  end

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
        if Rails::VERSION::STRING >= '5.2'
          option_tags = add_options(recurring_options_for_select(value, @default_schedules, @options), @options, value)
        else
          option_tags = add_options(recurring_options_for_select(value(object), @default_schedules, @options), @options, value(object))
        end
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
