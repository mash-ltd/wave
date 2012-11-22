require_relative '../../spec_helper'

describe Wave::Client do
  
  let(:client) { Wave::Client.instance }

  before do
    @keys = Wave::Configuration::VALID_CONFIG_KEYS
  end

  describe "Wave::Client.instance" do
    it { Wave::Client.instance.should be_kind_of(HTTParty) }
  end

  describe "loading" do
    !(defined?(Rails).nil?).should == true
  end

  describe "default attributes" do
    it "must have the base url set to the Raneen API endpoint" do
      Wave::Client.base_uri.should == 'http://raneen.tamkeencapital.com/api/v1'
    end
  end

  describe "configuration" do

    it "should hold the default data" do
      @keys.each do |key|
        client.send(key).should == Wave.send(key)
      end
    end

    describe "Load YML configuration" do
      before :each do
        @pwd = Dir.pwd
        @tmp_dir = File.join(File.dirname(__FILE__), 'tmp')
        FileUtils.mkdir_p(@tmp_dir)
        Dir.chdir(@tmp_dir)

        conf_file = "#{File.dirname(__FILE__)}/tmp/wave_config.yml"

        f = File.new("wave_config.yml", 'w')
        doc = %Q{
          test:
            endpoint: 'http://localhost:3000/api/v1'
            format: 'json'
            access_token: 'kjasdiuhasdhasiud'
        }

        f.puts(doc)
        f.close

        options = Wave.parse_config_file(conf_file)
        client.config(options)
      end

      it "should hold the correct data loaded from the yml" do
        client.endpoint.should == "http://localhost:3000/api/v1"
        client.format.should == "json"
        client.access_token.should == "kjasdiuhasdhasiud"
      end

      after do
        Dir.chdir(@pwd)
        FileUtils.rm_rf(@tmp_dir)
      end
    end

    after do
      client.reset_config
    end

    describe "reset configuration" do
      it "should have the right configuration before getting requests. resetting configuration" do
        client.endpoint.should == "http://raneen.tamkeencapital.com/api/v1"
        Wave::Client.base_uri.should == "http://raneen.tamkeencapital.com/api/v1"
      end
    end
  end

  # This test will only work in my database environment. ~ RR
  describe "GET profile" do
    before do
      @config = {
        :endpoint   => 'http://localhost:3000/api/v1',
        :access_token => "xCFoelebOlbnuzGUvFLkXFp5W8QbgTR77x8l0O68"
      }
      client.config(@config)
      VCR.insert_cassette 'base', :record => :new_episodes
    end

    after do
      VCR.eject_cassette
    end

    it "should have the right endpoint for testing" do
      client.endpoint.should == "http://localhost:3000/api/v1"
      client.access_token.should == "xCFoelebOlbnuzGUvFLkXFp5W8QbgTR77x8l0O68"
    end

    it "must have a profile method" do
      client.should respond_to :profile_info
    end

    it "must parse the api response from JSON to Hash" do
      client.profile_info.should be_an_instance_of Hash
    end

    it "must get the right profile information" do
      client.profile_info["name"].should == "mashsolvents"
    end

  end
end