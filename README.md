RecurringSelect
=============

[![Build Status](https://travis-ci.org/GetJobber/recurring_select.png?branch=master)](https://travis-ci.org/GetJobber/recurring_select) [![Code Climate](https://codeclimate.com/github/GetJobber/recurring_select.png)](https://codeclimate.com/github/GetJobber/recurring_select)

This is a gem to add a number of selectors and helpers for working with recurring schedules in a rails app.
It uses the [IceCube](https://github.com/seejohnrun/ice_cube) recurring scheduling gem.

Created by the [Jobber](http://getjobber.com) team for Jobber, the leading business management tool for field service companies.

Check out the [live demo](http://recurring-select-demo.herokuapp.com/) (code in [spec\dummy](https://github.com/GetJobber/recurring_select/tree/master/spec/dummy) folder)


Usage
-----

Basic selector:

Load the gem:
`gem 'recurring_select'`

Require assets
  Desktop view
    application.js
      `//= require recurring_select`
    application.css
      `//= require recurring_select`

  or jQueryMobile interface
    application.js
      `//= require jquery-mobile-rs`
    application.css
      `//= require jquery-mobile-rs`


In the form view call the helper:
`<%= f.select_recurring :recurring_rule_column %>`

Options
-------

Defaults Values
```
f.select_recurring :current_existing_rule, [
  IceCube::Rule.weekly.day(:monday, :wednesday, :friday),
  IceCube::Rule.monthly.day_of_month(-1)
]
```

:allow_blank let's you pick if there is a "not recurring" value
```
  f.select_recurring :current_existing_rule, nil, :allow_blank => true
```


Additional Helpers
------------------

RecurringSelect also comes with several helpers for parsing up the
parameters when they hit your application.

You can send the column into the `is_valid_rule?` method to check the
validity of the input.
`RecurringSelect.is_valid_rule?(possible_rule)`

There is also a `dirty_hash_to_rule` method for sanitizing the inputs
for IceCube. This is sometimes needed based on if you're receiving strings, fixed
numbers, strings vs symbols, etc.
`RecurringSelect.dirty_hash_to_rule(params)`

I18n
----
Recurrent select is I18n aware

You can create a locale file like this:

```
en:
  recurring_select:
    not_recurring: "- not recurring -"
    change_schedule: "Change schedule..."
    set_schedule: "Set schedule..."
    new_custom_schedule: "New custom schedule..."
    custom_schedule: "Custom schedule..."
    or: or
```

You have to translate javascript texts too by including the locale file in your assets manifest. Only french and english are supported for the moment

```
//= require recurring_select/en
//= require recurring_select/fr
```

For other languages include a file like this:

```
$.fn.recurring_select.texts = {
  repeat: "Repeat"
  frequency: "Frequency"
  daily: "Daily"
  weekly: "Weekly"
  monthly: "Monthly"
  yearly: "Yearly"
  every: "Every"
  days: "day(s)"
  weeks_on: "week(s) on"
  months: "month(s)"
  years: "year(s)"
  first_day_of_week: 1
  day_of_month: "Day of month"
  day_of_week: "Day of week"
  cancel: "Cancel"
  ok: "OK"
  days_first_letter: ["S", "M", "T", "W", "T", "F", "S" ]
  order: ["1st", "2nd", "3rd", "4th"]
}
```

Testing and development
----------------------

Start the dummy server for clicking around the interface:
`rails s`

Use [Guard](https://github.com/guard/guard) and RSpec for all tests. I'd
love to get jasmine running also, but haven't had time yet.

Tests can be ran against different versions of Rails like so:

```
BUNDLE_GEMFILE=spec/gemfiles/Gemfile.rails-3.2.x bundle install
BUNDLE_GEMFILE=spec/gemfiles/Gemfile.rails-3.2.x bundle exec rake spec
```

Feel free to open issues or send pull requests.

Licensing
---------
This project rocks and uses MIT-LICENSE.

