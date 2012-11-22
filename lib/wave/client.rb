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
      raise AuthenticationError.new(nil, nil, "Write operations require an access token") unless self.access_token
      get_object("user")
    end

    def message(args)
      raise AuthenticationError.new(nil, nil, "Write operations require an access token") unless self.access_token
      post_object("message", args)
    end

    def feed(args)
      raise AuthenticationError.new(nil, nil, "Write operations require an access token") unless self.access_token
      post_object("feed", args)
    end

    # Fetch information about a given connection (e.g. type of activity -- feed, events, photos, etc.)
    # for a specific user.
    #
    # @param connection_name what
    #
    # @return object hashes
    def get_object(connection_name)
      options = {token: self.access_token}
      self.class.get("/#{connection_name.pluralize}/index", query: options)
    end

    # Post information about a given connection (e.g. type of activity -- feed, events, photos, etc.)
    # for a specific user.
    #
    # @param connection_name what
    # @param args any additional arguments to be sent to Raneen
    #
    # @return object hashes
    def post_object(connection_name, args = {}, options = {})
      args[:token] =  self.access_token
      self.class.post("/#{connection_name.pluralize}/create", body: args)
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

      ###### BASE URI for HTTParty
      Wave::Client.base_uri merged_options[:endpoint].to_s
    end
  end
end