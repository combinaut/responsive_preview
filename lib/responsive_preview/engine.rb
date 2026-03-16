require 'responsive_preview/controller_extensions'

module ResponsivePreview
  class Engine < Rails::Engine

    initializer 'responsive_preview.load_controller_extensions' do |app|
      ActiveSupport.on_load(:action_controller) do
        include ControllerExtensions::InstanceMethods
      end
    end

    initializer 'responsive_preview.append_precompile_assets' do |app|
      config.assets.precompile += %w(responsive_preview.js)
    end

    initializer 'responsive_preview.load_helpers' do
      ActiveSupport.on_load(:action_controller) do
        require_relative '../../app/helpers/responsive_preview/view_helper'
        helper ResponsivePreview::ViewHelper
      end
    end
  end
end
