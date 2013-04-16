require 'spec_helper'

describe RecurringSelect do
  it "should be a module" do
    RecurringSelect.should be_kind_of Module
  end

  describe "#is_valid_rule?" do
    it "should identify invalid rules" do
      RecurringSelect.should_not be_is_valid_rule(nil)
      RecurringSelect.should_not be_is_valid_rule("")
      RecurringSelect.should_not be_is_valid_rule(false)
      RecurringSelect.should_not be_is_valid_rule("null")
      RecurringSelect.should_not be_is_valid_rule("0")
      RecurringSelect.should_not be_is_valid_rule("custom")
      RecurringSelect.should_not be_is_valid_rule([1, 2])
    end

    it "should identify valid rules" do
      RecurringSelect.should be_is_valid_rule(IceCube::Rule.weekly)
      RecurringSelect.should be_is_valid_rule(IceCube::Rule.weekly.to_hash)
      RecurringSelect.should be_is_valid_rule(IceCube::Rule.weekly.to_hash.to_json)
    end
  end

  describe "#filter_params" do
    it "Monthly with day_of_week" do
      RecurringSelect.filter_params({
        :validations=>{"day_of_week"=>{"wednesday"=>["1", "3"]}},
        :rule_type=>"IceCube::MonthlyRule",
        :interval=>1
      }).should == {
        :validations=>{:day_of_week =>{:wednesday =>[1, 3]}},
        :rule_type=>"IceCube::MonthlyRule",
        :interval=>1
      }

      RecurringSelect.filter_params({
        :validations=>{"day_of_week"=>{"2"=>["1", "3"]}},
        :rule_type=>"IceCube::MonthlyRule",
        :interval=>1
      }).should == {
        :validations=>{:day_of_week =>{2 =>[1, 3]}},
        :rule_type=>"IceCube::MonthlyRule",
        :interval=>1
      }
    end
  end

end
