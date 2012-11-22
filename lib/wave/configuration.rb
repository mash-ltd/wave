module Wave
  module Configuration
    VALID_CONNECTION_KEYS = [:endpoint, :user_agent, :method].freeze
    VALID_OPTIONS_KEYS    = [:access_token, :format].freeze
    VALID_CONFIG_KEYS     = VALID_CONNECTION_KEYS + VALID_OPTIONS_KEYS

    DEFAULT_ENDPOINT    = 'http://raneen.tamkeencapital.com/api/v1'
    DEFAULT_METHOD      = :get
    DEFAULT_USER_AGENT  = "Wave API Ruby Gem #{Wave::VERSION}".freeze

    DEFAULT_ACCESS_TOKEN = nil
    DEFAULT_FORMAT       = :json

    # Build accessor methods for every config options so we can do this, for example:
    #   Wave.format = :xml
    attr_accessor *VALID_CONFIG_KEYS

    # Make sure we have the default values set when we get 'extended'
    def self.extended(base)
      base.reset
    end

    def reset
      self.endpoint         = DEFAULT_ENDPOINT
      self.method           = DEFAULT_METHOD
      self.user_agent       = DEFAULT_USER_AGENT
  
      self.access_token     = DEFAULT_ACCESS_TOKEN
      self.format           = DEFAULT_FORMAT
    end

    def configure
      yield self
    end

    def options
      Hash[ * VALID_CONFIG_KEYS.map { |key| [key, send(key)] }.flatten ]
    end
    
  end
end