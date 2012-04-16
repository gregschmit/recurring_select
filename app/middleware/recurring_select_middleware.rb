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
        rule = RecurringSelect.dirty_hash_to_rule(params)
        [200, {"Content-Type" => "text/html"}, [rule.to_s]]
      else
        [200, {"Content-Type" => "text/html"}, [""]]
      end
    else
      @app.call(env)
    end
  end

end
