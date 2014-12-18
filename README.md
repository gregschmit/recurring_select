# Recurring Select

[![Build Status](https://travis-ci.org/GetJobber/recurring_select.png?branch=master)](https://travis-ci.org/GetJobber/recurring_select) [![Code Climate](https://codeclimate.com/github/GetJobber/recurring_select.png)](https://codeclimate.com/github/GetJobber/recurring_select)

This gem adds selectors and helpers for working with recurring schedules in a Rails app. It uses [ice_cube](https://github.com/seejohnrun/ice_cube) recurring scheduling gem.

Created by the [Jobber](http://getjobber.com) team for Jobber, the leading business management tool for field service companies.

Check out the [live demo](http://recurring-select-demo.herokuapp.com/) (code in [spec/dummy](https://github.com/GetJobber/recurring_select/tree/master/spec/dummy) folder)


## Usage

Basic selector:

Add the gem to your Gemfile:

```ruby
gem 'recurring_select'
```

### Require Assets

#### Desktop Interface:
- application.js: `//= require recurring_select`
- application.css: `//= require recurring_select`

#### jQuery Mobile Interface:
- application.js: `//= require jquery-mobile-rs`
- application.css: `//= require jquery-mobile-rs`

### Form Helper

In the form view call the helper:

```erb
<%= f.select_recurring :recurring_rule_column %>
```

#### Options

```ruby
f.select_recurring :current_existing_rule, [
  IceCube::Rule.weekly.day(:monday, :wednesday, :friday),
  IceCube::Rule.monthly.day_of_month(-1)
]
```

Use :allow_blank for a "not recurring" option:

```ruby
  f.select_recurring :current_existing_rule, nil, :allow_blank => true
```


### Additional Helpers

Recurring Select also comes with helpers for parsing the
parameters when they hit your application.

You can send the column into the `is_valid_rule?` method to check the
validity of the input.

```ruby
RecurringSelect.is_valid_rule?(possible_rule)
```

There is also a `dirty_hash_to_rule` method for sanitizing the inputs
for IceCube. This is sometimes needed if you're receiving strings, fixed
numbers, strings vs symbols, etc.

```ruby
RecurringSelect.dirty_hash_to_rule(params)
```

### I18n

Recurring Select is I18n aware

You can create a locale file like this:

```yaml
en:
  recurring_select:
    not_recurring: "- not recurring -"
    change_schedule: "Change schedule..."
    set_schedule: "Set schedule..."
    new_custom_schedule: "New custom schedule..."
    custom_schedule: "Custom schedule..."
    or: or
```

You have to translate JavaScript texts too by including the locale file in your assets manifest. Only French and English are supported for the moment.

```
//= require recurring_select/en
//= require recurring_select/fr
```

For other languages include a JavaScript file like this:

```coffeescript
$.fn.recurring_select.texts = {
  locale_iso_code: "fr"
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
  days_first_letter: ["S", "M", "T", "W", "T", "F", "S"]
  order: ["1st", "2nd", "3rd", "4th", "5th", "Last"]
}
```

Options include:

```coffeescript
$.fn.recurring_select.options = {
  monthly: {
    show_week: [true, true, true, true, false, false] //display week 1, 2 .... Last
  }
}
```

## Testing and Development

The dummy app uses a [Postgres](http://postgresapp.com/) database `recurring_select_development`. To get setup:

```console
bundle
rake db:create
```

Start the dummy server for clicking around the interface:

```console
rails s
```

Use [Guard](https://github.com/guard/guard) and RSpec for all tests. I'd
love to get Jasmine running also, but haven't had time yet.

Tests can be ran against different versions of Rails like so:

```
BUNDLE_GEMFILE=spec/gemfiles/Gemfile.rails-4.0.x bundle install
BUNDLE_GEMFILE=spec/gemfiles/Gemfile.rails-4.0.x bundle exec rspec spec
```

Feel free to open issues or send pull requests.

## Licensing

This project rocks and uses MIT-LICENSE.
