require_relative 'test_helper'

class ControllerExtensionsTest < Minitest::Test
  def test_default_wants_responsive_preview_is_false
    klass = Class.new { include ResponsivePreview::ControllerExtensions::InstanceMethods }
    refute klass.new.wants_responsive_preview?
  end

  def test_wants_responsive_preview_can_be_overridden
    klass = Class.new do
      include ResponsivePreview::ControllerExtensions::InstanceMethods
      def wants_responsive_preview?; true; end
    end
    assert klass.new.wants_responsive_preview?
  end
end
