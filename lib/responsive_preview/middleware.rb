module ResponsivePreview
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, body = @app.call(env)
      action_controller = env['action_controller.instance']

      if action_controller.try(:wants_responsive_preview?)
        original_response_body = body_to_string(body)
        body = action_controller.render_to_string(html: original_response_body, layout: "responsive_preview")
        headers["Content-Length"] = body.bytesize.to_s
        body = [body]
      end

      return [status, headers, body]
    end

    private

    def body_to_string(body)
      case body
      when String
        body
      else
        body.each.to_a.join
      end
    end
  end
end
