require_relative '../../spec_helper'

describe Wave::Configuration do
  
  # describe '.api_key' do
  #   it 'should return default key' do
  #     Wave.api_key.must_equal Wave::Configuration::DEFAULT_API_KEY
  #   end
  # end

  # describe '.format' do
  #   it 'should return default format' do
  #     Wave.format.must_equal Wave::Configuration::DEFAULT_FORMAT
  #   end
  # end

  # describe '.user_agent' do
  #   it 'should return default user agent' do
  #     Wave.user_agent.must_equal Wave::Configuration::DEFAULT_USER_AGENT
  #   end
  # end

  # describe '.method' do
  #   it 'should return default http method' do
  #     Wave.method.must_equal Wave::Configuration::DEFAULT_METHOD
  #   end
  # end

  # after do 
  #   Wave.reset
  # end

  # describe '.configure' do
  #   Wave::Configuration::VALID_CONFIG_KEYS.each do |key|
  #     it "should set the #{key}" do 
  #       Wave.configure do |config|
  #         config.send("#{key}=", key)
  #         Wave.send(key).must_equal key
  #       end
  #     end
  #   end
  # end

  # Wave::Configuration::VALID_CONFIG_KEYS.each do |key|
  #   describe ".#{key}" do
  #     it 'should return the default value' do
  #       Wave.send(key).must_equal Wave::Configuration.const_get("DEFAULT_#{key.upcase}")
  #     end
  #   end
  # end


end
