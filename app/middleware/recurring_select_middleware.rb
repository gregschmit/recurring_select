require "ice_cube"

class RecurringSelectMiddleware

  def initialize(app)
    @app = app
  end

  def call(env)
    regexp = /^\/recurring_select\/translate\/(.*)/
    if env["PATH_INFO"] =~ regexp
      I18n.locale = env["PATH_INFO"].scan(regexp).first.first
      params = env["action_dispatch.request.request_parameters"]

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
