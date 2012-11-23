module Errors
  # All graph API authentication failures.
  class WaveError < StandardError; end

  class AuthenticationError < WaveError 
    
    def initialize(message)
      super(message)
    end
  end
  
end