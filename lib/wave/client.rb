require 'erb'
require 'singleton'

module Wave
  class Client
    include Singleton
    
    # Define the same set of accessors as the Wave module
    attr_accessor *Configuration::VALID_CONFIG_KEYS
    
    include HTTParty

    def initialize
      # Merge the config values from the module and those configured in yaml file.
      options = Wave.get_yaml_options || {}
      set_config(options)
    end

    def config(options={})
      options ||= Wave.get_yaml_options
      set_config(options)
      self
    end

    def reset_config
      set_config(Wave.options)
    end

    def profile_info
      @profile_info = get_profile
    end

    private

    def set_config(options={})
      # Merge options
      merged_options = Wave.options.merge(options)
      # Copy the merged values to this client and ignore those
      # not part of our configuration
      Configuration::VALID_CONFIG_KEYS.each do |key|
        send("#{key}=", merged_options[key])
      end
      Wave::Client.base_uri merged_options[:endpoint].to_s
    end

    def get_object(object_url)
      options = {token: self.access_token}
      self.class.get(object_url, query: options)
    end

    def get_profile
      get_object("/users/index")
    end
  end
end