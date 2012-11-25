require "httparty"
require "rails"
require "wave/version"
require "wave/configuration"
require "wave/client"

module Wave
  extend Configuration

  # YAML options
  @@yaml_options = {}

  def self.set_options
    self.parse_config_file "#{Rails.root}/config/wave.yml"
  end

  # Loads the configuration file
  # @return {}
  def self.parse_config_file(path)
    return unless File.exists?(path)
    yaml_options = YAML::load(ERB.new(IO.read(path)).result)[Rails.env]
    @@yaml_options = yaml_options.inject({}){|sym_h,(k,v)| sym_h[k.to_sym] = v; sym_h}
  end

  # Gets yaml_options that was previously parsed or fetch the yaml file if params path was given
  # params[path] yaml file path
  # @return @@yaml_options
  def self.get_yaml_options(path="")
    @@yaml_options.empty? ? self.set_options : @@yaml_options
  end

end

require 'wave/errors'
# add rails integration
require('wave/railtie') if defined?(::Rails)
