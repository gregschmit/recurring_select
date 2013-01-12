require 'test_helper'

class RecurringSelectTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, RecurringSelect
  end

  test "is_valid_rule?" do
    assert !RecurringSelect.is_valid_rule?(nil)
    assert !RecurringSelect.is_valid_rule?("")
    assert !RecurringSelect.is_valid_rule?(false)
    assert !RecurringSelect.is_valid_rule?("null")
    assert !RecurringSelect.is_valid_rule?("0")
    assert !RecurringSelect.is_valid_rule?("custom")
    assert !RecurringSelect.is_valid_rule?([1, 2])

    assert RecurringSelect.is_valid_rule?(IceCube::Rule.weekly)
    assert RecurringSelect.is_valid_rule?(IceCube::Rule.weekly.to_hash)
    assert RecurringSelect.is_valid_rule?(IceCube::Rule.weekly.to_hash.to_json)
  end

  test "filter_params - Monthly with day_of_week" do
    assert_equal RecurringSelect.filter_params({
      :validations=>{"day_of_week"=>{"wednesday"=>["1", "3"]}},
      :rule_type=>"IceCube::MonthlyRule",
      :interval=>1
    }), {
      :validations=>{:day_of_week =>{:wednesday =>[1, 3]}},
      :rule_type=>"IceCube::MonthlyRule",
      :interval=>1
    }

    assert_equal RecurringSelect.filter_params({
      :validations=>{"day_of_week"=>{"2"=>["1", "3"]}},
      :rule_type=>"IceCube::MonthlyRule",
      :interval=>1
    }), {
      :validations=>{:day_of_week =>{2 =>[1, 3]}},
      :rule_type=>"IceCube::MonthlyRule",
      :interval=>1
    }
  end

end
