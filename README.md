# Wave

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'wave'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wave

## Usage

Configure wave with the following.
Create YML file `wave.yml` with the following configuration options:
    development:
      endpoint: URL_FOR_API ex: 'http://localhost:3000/api/v1'
      format: REQUESTED_FORMAT ex: 'json'
      access_token: CLIENT_ACCESS_TOKEN OR APP_ACCESS_TOKEN

You can set access_token afterwards to change it to the CLIENT_ACCESS_TOKEN if not available at the beginning by:
  Wave::Client.instance.config({access_token: CLIENT_ACCESS_TOKEN})

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
