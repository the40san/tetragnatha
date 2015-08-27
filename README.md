## Installation
1. add this to your Gemfile

```
WIP
```

## Usage

1. Write your spider endpoint to your database.yml
```yaml
# config/database.yml

spider_endpoint1:
  host: spider1.example.com
  port: 3306
  username: spider
  password: password
```

2. Add your spider endpoint settings to your models like below

```ruby
# app/models/user.rb

class User < ActiveRecord::Base
  spider_at :spider_endpoint1
end
```

3. then run migrations

```
$ bundle exec rake db:migrate
```

## Contributing

1. Fork it ( https://github.com/the40san/tetragnatha/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
