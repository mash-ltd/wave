require 'simplecov'
SimpleCov.start do 
  add_filter '/spec/'
end

ENV["RAILS_ENV"] = "test"
#dependencies
require 'rspec'

#we need the actual library file
require_relative '../lib/wave'

require 'bundler'
require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'
require 'turn'

Bundler.require :default, :development, :test

RSpec.configure do |config|
  Fabrication.configure do |config|
    config.fabricator_path = 'fabricators'
    config.path_prefix = File.dirname(__FILE__)
  end

  config.before(:all) do
   %w(tmp tmp/pids tmp/cache).each do |path|
      FileUtils.mkdir_p "#{Dir.pwd}/#{path}"
    end
  end
end

Turn.config do |c|
 # :outline  - turn's original case/test outline mode [default]
 c.format  = :outline
 # turn on invoke/execute tracing, enable full backtrace
 c.trace   = true
 # use humanized test names (works only with :outline format)
 c.natural = true
end
#VCR config
VCR.config do |c|
  c.cassette_library_dir = 'spec/fixtures/wave_cassettes'
  c.stub_with :webmock
end