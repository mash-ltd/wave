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
```yaml
development:
  endpoint:     "URL_FOR_API"       ex: 'http://localhost:3000/api/v1'
  format:       "REQUESTED_FORMAT"  ex: 'json'
  access_token: "OAUTH_ACCESS_TOKEN"
```
OR you can pass your configuration to the Client directly without using the yml file by the following:
```ruby
options = { endpoint: "URL_FOR_API", format: "REQUESTED_FORMAT", access_token: "OAUTH_ACCESS_TOKEN" }
@wave = Wave::Client.config(options)
```

You can set access_token afterwards to change it to the `CLIENT_ACCESS_TOKEN` if not available at the beginning by:
```ruby
Wave::Client.instance.api_key(CLIENT_ACCESS_TOKEN)
```

After configuring your client API you can use it normally and send a message or post on Raneen's feed.

To send a message:
```ruby
@message_hash = {
    message: {
        body: "Hey there from Wave API!", 
        recipient_ids: RECIPIENT_UID
    }
}
RECIPIENT_TYPE which entity type you are talking to ex: "company" or "user" 
@wave.message(@message_hash, RECIPIENT_TYPE)
```
To post on `current_user` feed:
```ruby
@feed = {
  feed_item: {
    content: "Hey via Wave API."
  }
}
@wave.feed(@feed)
```
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
