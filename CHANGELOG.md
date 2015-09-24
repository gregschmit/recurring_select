# 2.0.0 / 2015-09-24

* [BREAKING-CHANGE] Dropping support for rails 3.X - Upgrade to sass-rails 4
* [FIX] Rename all css.scss to .scss [#86](https://github.com/GetJobber/recurring_select/pull/86)

# 1.2.4 / 2014-10-17

* Options to show 5th week and last week in monthly recurring UI. [#66](https://github.com/GetJobber/recurring_select/pull/66) (thanks @naomiaro)

# 1.2.3 / 2014-10-01

* Revert fix hidden dialog when called from Bootstrap modal. [#47](https://github.com/GetJobber/recurring_select/pull/47)

# 1.2.2 / 2014-09-29

* Show currently selected rule first when selected [#65](https://github.com/GetJobber/recurring_select/pull/65) (thanks @ericmwalsh)
* [FIX] Add some explicit CSS rules to fix issues with Zurb Foundation. [#50](https://github.com/GetJobber/recurring_select/pull/50) (thanks @ndbroadbent)
* [FIX] Fix hidden dialog when called from Bootstrap modal. [#47](https://github.com/GetJobber/recurring_select/pull/47) (thanks @rgrwatson85)
* [FIX] Fix dialog in IE. [#46](https://github.com/GetJobber/recurring_select/pull/46) (thanks @ttp)
* [FIX] Fix rebinding for day of the week selection [#60](https://github.com/GetJobber/recurring_select/pull/60) (thanks @joshjordan)
* Travis CI: Testing against latest point releases of Rails.

# 1.2.1 / 2014-02-12

* Add LICENSE to gemspec
* Testing JRuby on Travis CI, removing appraisal.

# 1.2.1.rc3 / 2013-11-11

* [FIX] Issue where the select sometimes throws an uninitialized
constant (thanks @fourseven)

# 1.2.1.rc2 / 2013-10-30

* [FIX] Recurring select input displays inconsistently in development
* [FIX] dirty_hash_to_rule was modifying its argument [#35](https://github.com/GetJobber/recurring_select/pull/35) (thanks @asgeo1)
* [FIX] Handle empty hashes [#36](https://github.com/GetJobber/recurring_select/pull/36) (thanks @asgeo1)

# 1.2.1.rc1 / 2013-08-07

* [FIX] For blank select fields.
* Testing multiple Rails versions in Travis CI.

# 1.2.0 / 2013-07-03

* [ENHANCEMENT] I18n aware [#19](https://github.com/GetJobber/recurring_select/pull/19) (thanks @vddgil)
* remove IceCube::ValidatedRule#to_s monkey patch [#21](https://github.com/GetJobber/recurring_select/pull/21) (thanks @ajsharp)

# 1.1.0 / 2013-06-27

* [ENHANCEMENT] Rails 4 support (thanks @afhammad) #17

# 1.0.2 / 2013-04-30

* [ENHANCEMENT] Allow dialog summary to wrap (thanks @mhchen) #4

# 1.0.1 / 2013-04-25

* [FIX] convert week_start value to integer (thanks @rubenrails) #2
* [FIX] recurring_select should be able to handle a string as the input #1

# 1.0.0 / 2013-04-16

* First public release

