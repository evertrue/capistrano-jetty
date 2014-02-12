# Capistrano::Jetty

This gem provides support in Capistrano 3.x for copying a deployed artifact into Jetty’s webapps directory, then restarting Jetty.

Plays nicely with [evertrue/capistrano-scm-jenkins](https://github.com/evertrue/capistrano-scm-jenkins).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano-jetty'
```

And then execute:

```bash
$ bundle
```

## Usage

This Gem requires that your deploy user have *passwordless sudo rights* to run
`service jetty restart`. See [Capistrano’s Authorisation docs](http://capistranorb.com/documentation/getting-started/authentication-and-authorisation/#toc_8)
for a simple example.

In `Capfile`:
```ruby
require 'capistrano-jetty/jetty'
```

In your `config/deploy.rb`:

```ruby
# Filename to grab from your current_path & copy to
set :deployed_artifact_filename, "#{fetch(:application)}.war"

# Path to your Jetty webapps directory
set :jetty_webapps_path, '/usr/share/jetty/webapps'
```

## Contributing

1. Fork it ( http://github.com/evertrue/capistrano-jetty/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
