# Windsong

Windsong is Ruby on Rails app which provides open-source wind data.
It is created with needs of kite-surfing and other wind sports in mind.

All commands in this readme should be run from project root unless otherwise specified.

## Requirements

* Ruby 2.1.1
* [Mongodb](http://www.mongodb.org/) > 2.4.9

## Recommended
* [RVM](http://rvm.io)

## Installing
See Mongodb documentation for installation instructions.
If you using RVM it should automatically detect ruby version and gemset when you `cd` into the app directory.

* $ `mongod`
* $ `bundle install`
* $ `rake db:setup`

## Documentation
This app uses [YARD](http://yardoc.org/) for documentation. You can run the yard documentation server with:
```yard server```
Then point a web browser at [Your local YARD documentation](http://localhost:8088). It will reload automatically if the
source changes.

## Testing
This app uses [RSpec](http://rspec.info/). "Expect" syntax only please!

### Continuous testing
This app can be continuously tested with Guard
$ `guard`

## Deployment
This app is aimed at the excellent [Heroku](http://www.heroku.com) cloud SAAS platform.