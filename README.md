# Faraday Logstasher

A `ActiveSupport::LogSubscriber` to log HTTP requests made by a [Faraday](https://github.com/lostisland/faraday) client instance, into [Logstasher](https://github.com/shadabahmed/logstasher).

Forked from [faraday-log-subscriber](https://github.com/plataformatec/faraday-log-subscriber).

## Installation

Add it to your Gemfile:

```ruby
gem 'faraday-logstasher'
```

## Usage

You have to use the `:instrumentation` middleware from [`faraday_middleware`](https://github.com/lostisland/faraday_middleware) to
instrument your requests.

```ruby
client = Faraday.new('https://api.github.com') do |builder|
  builder.use :instrumentation
  builder.adapter :net_http
end

client.get('repos/rails/rails')
# {"name":"request.faraday","host":"api.github.com","method":"GET","request_uri":"/repos/rails/rails","status":200,"duration":551.33,"source":"unknown","tags":[],"@timestamp":"2016-09-22T14:24:08.047Z","@version":"1"}
```

### `faraday-http-cache` integration

If you use the [`faraday-http-cache`](https://github.com/plataformatec/faraday-http-cache) gem, an extra line will be logged regarding
the cache status of the requested URL:


```ruby
client = Faraday.new('https://api.github.com') do |builder|
  builder.use :instrumentation
  builder.use :http_cache, instrumenter: ActiveSupport::Notifications
  builder.adapter :net_http
end

client.get('repos/rails/rails')
client.get('repos/rails/rails')
# {"name":"http_cache.faraday","host":"api.github.com","request_uri":"/repos/rails/rails","cache_status":"fresh","source":"unknown","tags":[],"@timestamp":"2016-09-22T14:25:41.141Z","@version":"1"}
# {"name":"request.faraday","host":"api.github.com","method":"GET","request_uri":"/repos/rails/rails","status":200,"duration":1.98,"source":"unknown","tags":[],"@timestamp":"2016-09-22T14:25:41.142Z","@version":"1"}

```

## License

Copyright (c) 2015 Plataformatec.
Copyright (c) 2016 Unity Technologies ApS.
See LICENSE file.
