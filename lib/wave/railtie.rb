require 'wave'

module Wave
  module Rails3
    if defined?(Rails::Railtie)
      class Railtie < Rails::Railtie

        initializer :load_wave_config do 
          Wave.set_options
        end
      end
    end
  end
end