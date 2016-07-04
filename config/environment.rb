require "nokogiri"
require "open-uri"
require "phantomjs"
require "capybara"
require "capybara/dsl"
require "capybara/poltergeist"
require "pry"
require "colorize"

Capybara.default_driver = :poltergeist
Capybara.run_server = false
Capybara.default_max_wait_time = 120
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(
    app,
    debug:             false,
    js_errors:         false,
    inspector:         false,
    phantomjs_logger:  File.open("log/test_phantomjs.log", "w+"),
    phantomjs_options: ['--load-images=false', '--disk-cache=false', '--ignore-ssl-errors=true']
  )
end

require_relative "../lib/local_weather/version"
require_relative "../lib/local_weather/scraper"
require_relative "../lib/local_weather/cli"
