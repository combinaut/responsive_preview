require_relative 'test_helper'

class EngineBootTest < Minitest::Test
  def self.app
    @app ||= begin
      Class.new(Rails::Application) do
        config.eager_load = true
        config.root = File.expand_path('..', __dir__)
        config.logger = Logger.new(IO::NULL)
        config.secret_key_base = 'test'
        config.hosts.clear if config.respond_to?(:hosts)
      end.tap(&:initialize!)
    end
  end

  def test_app_boots_and_helper_is_available
    self.class.app
    assert defined?(ResponsivePreview::ViewHelper)
    assert ActionController::Base.helpers.respond_to?(:responsive_preview_js)
  end
end
