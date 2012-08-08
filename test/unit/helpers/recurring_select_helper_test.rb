require 'test_helper'

class RecurringSelectHelperTest < ActionView::TestCase

  class FromTester
    include RecurringSelectHelper::FormOptionsHelper
  end

  test "#recurring_options_for_select - basic" do
    subject = FromTester.new
    subject.expects(:options_for_select).with(
      [
        ['- not recurring -', 'null'],
        ['Set schedule...', 'custom']
      ], 'null'
    )
    subject.recurring_options_for_select
  end

  test "#recurring_options_for_select - no defaults but custom rule" do
    subject = FromTester.new
    subject.expects(:options_for_select).with(
      [
        ["Weekly", IceCube::Rule.weekly.to_hash.to_json],
        ['or', {:disabled => true}],
        ['Change schedule...', 'custom']
      ], IceCube::Rule.weekly.to_hash.to_json
    )
    subject.recurring_options_for_select(IceCube::Rule.weekly, [])
  end

  test "#recurring_options_for_select - defaults with no rule" do
    subject = FromTester.new
    subject.expects(:options_for_select).with(
      [
        ["Weekly", IceCube::Rule.weekly.to_hash.to_json],
        ["Monthly", IceCube::Rule.monthly.to_hash.to_json],
        ['or', {:disabled => true}],
        ['Custom schedule...', 'custom']
      ], 'null'
    )
    subject.recurring_options_for_select(nil, [IceCube::Rule.weekly, IceCube::Rule.monthly])
  end

  test "#recurring_options_for_select - non-recurring rule with defaults" do
    subject = FromTester.new
    subject.expects(:options_for_select).with(
      [
        ["- not recurring -", 'null'],
        ["different", 1],
        ["Weekly", IceCube::Rule.weekly.to_hash.to_json],
        ['or', {:disabled => true}],
        ['Custom schedule...', 'custom']
      ], '1'
    )
    subject.recurring_options_for_select(1, [["different", 1], IceCube::Rule.weekly], :allow_blank => true)
  end
end
