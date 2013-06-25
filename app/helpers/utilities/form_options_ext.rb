module RecurringSelectHelper
  module FormOptionsHelper
    def recurring_options_for_select(currently_selected_rule = nil, default_schedules = nil, options = {})

      options_array = []
      blank_option_label = options[:blank_label] || "- not recurring -"
      blank_option = [blank_option_label, "null"]
      separator = ["or", {:disabled => true}]

      if default_schedules.blank?
        if currently_selected_rule
          options_array << blank_option if options[:allow_blank]
          options_array << ice_cube_rule_to_option(currently_selected_rule)
          options_array << separator
          options_array << ["Change schedule...", "custom"]
        else
          options_array << blank_option
          options_array << ["Set schedule...", "custom"]
        end
      else
        options_array << blank_option if options[:allow_blank]

        options_array += default_schedules.collect{|dc|
          ice_cube_rule_to_option(dc)
        }

        if currently_selected_rule and not current_rule_in_defaults?(currently_selected_rule, default_schedules)
          options_array << ice_cube_rule_to_option(currently_selected_rule, true)
          custom_label = ["New custom schedule...", "custom"]
        else
          custom_label = ["Custom schedule...", "custom"]
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
end
