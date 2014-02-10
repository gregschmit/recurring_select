require "recurring_select/engine"
require "ice_cube"

module RecurringSelect

  def self.dirty_hash_to_rule(params)
    if params.is_a? IceCube::Rule
      params
    else
      params = JSON.parse(params) if params.is_a?(String)
      rules_hash = filter_params(params.symbolize_keys!)
      IceCube::Rule.from_hash(rules_hash)
    end
  end

  def self.is_valid_rule?(possible_rule)
    return false if possible_rule.blank?
    case possible_rule
    when IceCube::Rule, Hash then true
    when String then !!JSON.parse(possible_rule) rescue false
    else false
    end
  end

  private

  def self.filter_params(params)
    params.reject!{|key, value| value.blank? || value=="null" }

    params[:interval] = params[:interval].to_i if params[:interval]
    params[:week_start] = params[:week_start].to_i if params[:week_start]

    params[:validations] ||= {}
    params[:validations].symbolize_keys!

    [:day, :day_of_month, :day_of_year, :hour_of_day, :minute_of_hour].each do |key|
      val = params[:validations][key]
      params[:validations][key] = (val.is_a? Array) ? val.collect(&:to_i) : val.to_i if val
    end

    if params[:validations][:day_of_week]
      if params[:validations][:day_of_week].length > 0 and not params[:validations][:day_of_week].keys.first =~ /\d/
        params[:validations][:day_of_week].symbolize_keys!
      else
        originals = params[:validations][:day_of_week].dup
        params[:validations][:day_of_week] = {}
        originals.each { |key, value| params[:validations][:day_of_week][key.to_i] = value }
      end
      params[:validations][:day_of_week].each{ |key, value| params[:validations][:day_of_week][key] = value.collect(&:to_i) }
    end

    params
  end
end
