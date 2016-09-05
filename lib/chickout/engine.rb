module Chickout
  class Engine < ::Rails::Engine
    require 'byebug'
    require 'draper'
    require 'aasm'

    isolate_namespace Chickout

    config.autoload_paths += %W(#{Chickout::Engine.root}/lib/chickout)

    config.generators do |g|
      g.test_framework      :rspec,        :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.assets false
      g.helper false
    end
  end
end
