require "recurring_select/engine"

module RecurringSelect

  def self.dirty_hash_to_rule(params)
    if params.is_a? IceCube::Rule
      params
    else
      if params.is_a?(String)
        params = JSON.parse(params)
      end

      params.symbolize_keys!
      rules_hash = filter_params(params)
      IceCube::Rule.from_hash(rules_hash)
    end
  end

  def self.is_valid_rule?(possible_rule)
    if possible_rule.blank? or
      ( possible_rule.is_a?(String) and (possible_rule=~/^null|false|0|custom$/) ) or
      new_rule.is_a?(FalseClass)
      false
    else
      true
    end
  end

  private

  def self.filter_params(params)
    params.reject!{|key, value| value.blank? || value=="null" }

    params[:interval] = params[:interval].to_i if params[:interval]

    params[:validations] ||= {}
    params[:validations].symbolize_keys!
    if params[:validations][:day]
      params[:validations][:day] = params[:validations][:day].collect{|d| d.to_i }
    end
    if params[:validations][:day_of_month]
      params[:validations][:day_of_month] = params[:validations][:day_of_month].collect{|d| d.to_i }
    end
    if params[:validations][:day_of_year]
      params[:validations][:day_of_year] = params[:validations][:day_of_year].collect{|d| d.to_i }
    end

    params
  end

end
