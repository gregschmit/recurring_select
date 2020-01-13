//= require recurring_select_dialog

const $ = jQuery;
$(function () {
  $(document).on("focus", ".recurring_select", function () {
    return $(this).recurring_select('set_initial_values');
  });

  return $(document).on("change", ".recurring_select", function () {
    return $(this).recurring_select('changed');
  });
});

var methods = {
  set_initial_values() {
    this.data('initial-value-hash', this.val());
    return this.data('initial-value-str', $(this.find("option").get()[this.prop("selectedIndex")]).text());
  },

  changed() {
    if (this.val() === "custom") {
      return methods.open_custom.apply(this);
    } else {
      return methods.set_initial_values.apply(this);
    }
  },

  open_custom() {
    this.data("recurring-select-active", true);
    new RecurringSelectDialog(this);
    return this.blur();
  },

  save(new_rule) {
    this.find("option[data-custom]").remove();
    const new_json_val = JSON.stringify(new_rule.hash);

    // TODO: check for matching name, and replace that value if found

    if ($.inArray(new_json_val, this.find("option").map(function () {
        return $(this).val();
      })) === -1) {
      methods.insert_option.apply(this, [new_rule.str, new_json_val]);
    }

    this.val(new_json_val);
    methods.set_initial_values.apply(this);
    return this.trigger("recurring_select:save");
  },

  current_rule() {
    return {
      str: this.data("initial-value-str"),
      hash: $.parseJSON(this.data("initial-value-hash"))
    };
  },

  cancel() {
    this.val(this.data("initial-value-hash"));
    this.data("recurring-select-active", false);
    return this.trigger("recurring_select:cancel");
  },


  insert_option(new_rule_str, new_rule_json) {
    let separator = this.find("option:disabled");
    if (separator.length === 0) {
      separator = this.find("option");
    }
    separator = separator.last();

    const new_option = $(document.createElement("option"));
    new_option.attr("data-custom", true);

    if (new_rule_str.substr(new_rule_str.length - 1) !== "*") {
      new_rule_str += "*";
    }

    new_option.text(new_rule_str);
    new_option.val(new_rule_json);
    return new_option.insertBefore(separator);
  },

  methods() {
    return methods;
  }
};

$.fn.recurring_select = function (method) {
  if (method in methods) {
    return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
  } else {
    return $.error(`Method ${method} does not exist on jQuery.recurring_select`);
  }
};

$.fn.recurring_select.options = {
  monthly: {
    show_week: [true, true, true, true, false, false]
  }
};

$.fn.recurring_select.texts = {
  locale_iso_code: "en",
  repeat: "Repeat",
  last_day: "Last Day",
  frequency: "Frequency",
  daily: "Daily",
  weekly: "Weekly",
  monthly: "Monthly",
  yearly: "Yearly",
  every: "Every",
  days: "day(s)",
  weeks_on: "week(s) on",
  months: "month(s)",
  years: "year(s)",
  day_of_month: "Day of month",
  day_of_week: "Day of week",
  cancel: "Cancel",
  ok: "OK",
  summary: "Summary",
  first_day_of_week: 0,
  days_first_letter: ["S", "M", "T", "W", "T", "F", "S"],
  order: ["1st", "2nd", "3rd", "4th", "5th", "Last"],
  show_week: [true, true, true, true, false, false]
};