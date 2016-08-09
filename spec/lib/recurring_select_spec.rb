require 'spec_helper'

describe RecurringSelect do
  it "should be a module" do
    expect(RecurringSelect).to be_kind_of Module
  end

  describe "#is_valid_rule?" do
    it "should identify invalid rules" do
      expect(RecurringSelect).not_to be_is_valid_rule(nil)
      expect(RecurringSelect).not_to be_is_valid_rule("")
      expect(RecurringSelect).not_to be_is_valid_rule(false)
      expect(RecurringSelect).not_to be_is_valid_rule("null")
      expect(RecurringSelect).not_to be_is_valid_rule("0")
      expect(RecurringSelect).not_to be_is_valid_rule("custom")
      expect(RecurringSelect).not_to be_is_valid_rule([1, 2])
    end

    it "should identify valid rules" do
      expect(RecurringSelect).to be_is_valid_rule(IceCube::Rule.weekly)
      expect(RecurringSelect).to be_is_valid_rule(IceCube::Rule.weekly.to_hash)
      expect(RecurringSelect).to be_is_valid_rule(IceCube::Rule.weekly.to_hash.to_json)
    end
  end

  describe "#filter_params" do
    it "Monthly with day_of_week" do
      expect(RecurringSelect.filter_params({
        :validations=>{"day_of_week"=>{"wednesday"=>["1", "3"]}},
        :rule_type=>"IceCube::MonthlyRule",
        :interval=>1
      })).to eq({
        :validations=>{:day_of_week =>{:wednesday =>[1, 3]}},
        :rule_type=>"IceCube::MonthlyRule",
        :interval=>1
      })

      expect(RecurringSelect.filter_params({
        :validations=>{"day_of_week"=>{"2"=>["1", "3"]}},
        :rule_type=>"IceCube::MonthlyRule",
        :interval=>1
      })).to eq({
        :validations=>{:day_of_week =>{2 =>[1, 3]}},
        :rule_type=>"IceCube::MonthlyRule",
        :interval=>1
      })
    end
  end

end
