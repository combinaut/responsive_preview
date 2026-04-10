require_relative 'test_helper'

class MiddlewareTest < Minitest::Test
  def setup
    @app = lambda { |env| [200, { 'Content-Type' => 'text/html' }, ['<p>hello</p>']] }
    @middleware = ResponsivePreview::Middleware.new(@app)
  end

  def test_passes_through_when_no_controller
    status, headers, body = @middleware.call({})
    assert_equal 200, status
    assert_equal ['<p>hello</p>'], body
    assert_nil headers['Content-Length']
  end

  def test_passes_through_when_controller_does_not_want_preview
    controller = Object.new
    def controller.wants_responsive_preview?; false; end

    status, _headers, body = @middleware.call('action_controller.instance' => controller)
    assert_equal 200, status
    assert_equal ['<p>hello</p>'], body
  end

  def test_wraps_response_when_controller_wants_preview
    controller = Object.new
    def controller.wants_responsive_preview?; true; end
    def controller.render_to_string(opts)
      "<iframe>#{opts[:html]}</iframe>"
    end

    status, headers, body = @middleware.call('action_controller.instance' => controller)
    assert_equal 200, status
    assert_equal ['<iframe><p>hello</p></iframe>'], body
    assert_equal '29', headers['Content-Length']
  end

  def test_handles_array_body
    app = lambda { |env| [200, {}, ['<p>', 'hello', '</p>']] }
    middleware = ResponsivePreview::Middleware.new(app)

    captured = nil
    controller = Object.new
    controller.define_singleton_method(:wants_responsive_preview?) { true }
    controller.define_singleton_method(:render_to_string) do |opts|
      captured = opts[:html]
      "wrapped"
    end

    middleware.call('action_controller.instance' => controller)
    assert_equal '<p>hello</p>', captured
    assert captured.html_safe?
  end
end
