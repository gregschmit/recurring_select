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
`gem 'recurring_select`

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
  f.select_recurring :current_existing_rule, :allow_blank => true
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


Testing and development
----------------------

Start the dummy server for clicking around the interface:
`rails s`

Use [Guard](https://github.com/guard/guard) and RSpec for all tests. I'd
love to get jasmine running also, but haven't had time yet.

Tests can be ran against different versions of Rails like so:

```
RAILS_VERSION=4.0.0 SASS_VERSION=4.0.0 bundle update
RAILS_VERSION=4.0.0 SASS_VERSION=4.0.0 bundle exec rspec spec
```


Feel free to open issues or send pull requests.

Licensing
---------
This project rocks and uses MIT-LICENSE.
