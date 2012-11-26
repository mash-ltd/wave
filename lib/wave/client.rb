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
      options = Wave.get_yaml_options if options.empty?
      set_config(options)
    end

    def api_key(access_token)
      self.access_token = access_token
    end

    def reset_config
      set_config(Wave.options)
    end

    def profile_info
      get_object("user")
    end

    def feed(message)
      feed_item = {feed_item: { content: message}}
      post_to_feed(feed_item)
    end

    def send_message(message, recipient_id, recipient_type)
      message = {message: {body: message, recipient_ids: recipient_id}}
      message(message, recipient_type)
    end

    # Sending a message to a user/company in Raneen
    #
    # @params args any additional arguments to be sent to Raneen e.g: "{message: {body: "hey", recipient_ids: "1234"}}"
    # @param entity_type e.g. type of the entity i am posting to -- company or user.
    # @return response hash
    def message(args, entity_type)
      args[:message][:recipient_ids] = entity_type + "-" + args[:message][:recipient_ids] 
      post_object("message", args).parsed_response
    end

    def post_to_feed(args)
      post_object("feed", args).parsed_response
    end

    # Fetch information about a given connection (e.g. type of activity -- feed, events, photos, etc.)
    # for a specific user.
    #
    # @param connection_name what
    #
    # @return object hashes
    def get_object(connection_name, options={})
      raise Errors::AuthenticationError.new("Get operations require an access token") unless self.access_token
      options[:token] = self.access_token
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
      raise Errors::AuthenticationError.new("Write operations require an access token") unless self.access_token
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