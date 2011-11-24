require "ice_cube"

class RecurringSelectMiddleware
  
  def initialize(app)
    @app = app
  end
  
  def call(env)
    if env["PATH_INFO"] =~ /^\/recurring_select\/translate/
      request = Rack::Request.new(env)
      params = request.params
      params.symbolize_keys!

      if params and params[:rule_type]
        rules_hash = filtered_params(params)
        
        rule = IceCube::Rule.from_hash(rules_hash)
        [200, {"Content-Type" => "text/html"}, [rule.to_s]]
      else
        [200, {"Content-Type" => "text/html"}, [""]]
      end
    else
      @app.call(env)
    end
  end
  
private

  def filtered_params(params)
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