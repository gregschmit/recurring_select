require "recurring_select/engine"
require "ice_cube"

module RecurringSelect

  def self.dirty_hash_to_rule(params)
    Rails.logger.info "RecurringSelect.dirty_hash_to_rule params: #{params}"
    if params.is_a? IceCube::Rule
      params
    else
      params = JSON.parse(params, quirks_mode: true) if params.is_a?(String)
      if params.nil?
        nil
      else
        params = params.symbolize_keys
        rules_hash = self.filter_params(params)
        rule_str = IceCube::Rule.from_hash(rules_hash)
        Rails.logger.info "RecurringSelect.dirty_hash_to_rule response: '#{rule_str}' for #{params.inspect}"
        rule_str
      end

    end
  end

  def self.is_valid_rule?(possible_rule)
    return true if possible_rule.is_a?(IceCube::Rule)
    return false if possible_rule.blank?

    if possible_rule.is_a?(String)
      begin
        JSON.parse(possible_rule)
        return true
      rescue JSON::ParserError
        return false
      end
    end

    # TODO: this should really have an extra step where it tries to perform the final parsing
    return true if possible_rule.is_a?(Hash)

    false #only a hash or a string of a hash can be valid
  end

  private

  def self.filter_params(params)
    params.reject!{|key, value| value.blank? || value=="null" }

    params[:interval] = params[:interval].to_i if params[:interval]
    params[:week_start] = params[:week_start].to_i if params[:week_start]
    params[:count] = params[:count].to_i if params[:count]
    if params[:until]
      p = Date.strptime(params[:until], '%m/%d/%Y') rescue nil
      if p
        params[:until] = p.to_s
      else
        params.delete(:until)
      end
    end

    params[:validations] ||= {}
    params[:validations].symbolize_keys!

    if params[:validations][:day]
      params[:validations][:day] = params[:validations][:day].collect(&:to_i)
    end

    if params[:validations][:day_of_month]
      params[:validations][:day_of_month] = params[:validations][:day_of_month].collect(&:to_i)
    end

    # this is soooooo ugly
    if params[:validations][:day_of_week]
      params[:validations][:day_of_week] ||= {}
      if params[:validations][:day_of_week].length > 0 and not params[:validations][:day_of_week].keys.first =~ /\d/
        params[:validations][:day_of_week].symbolize_keys!
      else
        originals = params[:validations][:day_of_week].dup
        params[:validations][:day_of_week] = {}
        originals.each{|key, value|
          params[:validations][:day_of_week][key.to_i] = value
        }
      end
      params[:validations][:day_of_week].each{|key, value|
        params[:validations][:day_of_week][key] = value.collect(&:to_i)
      }
    end

    if params[:validations][:day_of_year]
      params[:validations][:day_of_year] = params[:validations][:day_of_year].collect(&:to_i)
    end

    params
  end
end
