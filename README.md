# LocalWeather

This gem is a command line weather app that provides current weather, hourly, and 10 day forecasts based on zip code input. The data is scraped from the Weather Channel using Capybara/Poltergeist running PhantomJS as the headless browser to fire the JS app that renders the Weather Channel data.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'local_weather'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install local_weather

    ## Installing PhantomJS ##

    You need at least PhantomJS 1.8.1.  There are *no other external
    dependencies* (you don't need Qt, or a running X server, etc.)

    ### Mac ###

    * *Homebrew*: `brew install phantomjs`
    * *MacPorts*: `sudo port install phantomjs`
    * *Manual install*: [Download this](https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-macosx.zip)

    ### Linux ###

    * Download the [32 bit](https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-linux-i686.tar.bz2)
    or [64 bit](https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-linux-x86_64.tar.bz2)
    binary.
    * Extract the tarball and copy `bin/phantomjs` into your `PATH`

    ### Windows ###
    * Download the [precompiled binary](https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-windows.zip)
    for Windows

    ### Manual compilation ###

    Do this as a last resort if the binaries don't work for you. It will
    take quite a long time as it has to build WebKit.

    * Download [the source tarball](https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-source.zip)
    * Extract and cd in
    * `./build.sh`

    (See also the [PhantomJS building
    guide](http://phantomjs.org/build.html).)

## Usage

1. run ./bin/local_weather
2. enter zip code for area of interest
3. enter selection from menu to expand data
4. type 'quit' or 'exit' to exit application

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/local_weather.
