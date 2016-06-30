require "nokogiri"
require "open-uri"
require "phantomjs"
# require "capybara"
require "capybara/poltergeist"
require "pry"

class LocalWeather::Scraper
  # This class is the scraper used by the CLI class to pull
  # weather data in current, hourly, and 10 day forecasts from the
  # Weather Channel.com by zip code passed in from the CLI.

  include Capybara::DSL

  BASE_URL = "https://weather.com/weather/today/l/"

  def self.get_site(zip)
    # browser = Watir::Browser.new(:phantomjs)
    # browser.goto BASE_URL + zip
    # html = open(BASE_URL + zip)
    # Capybara.register_driver :poltergeist do |app|
    #   Capybara::Poltergeist::Driver.new(app, js_errors: false)
    # end
    Capybara.default_driver = :poltergeist

    Capybara::DSL.visit "http://ngauthier.com/"

    all(".posts .post").each do |post|
      title = post.find("h3 a").text
      url = post.find("h3 a")["href"]
      date = post.find("h3 small").text
      summary = post.find("p.preview").text

      puts title
      puts url
      puts date
      puts summary
      puts ""
    end


    # binding.pry
    # doc = Nokogiri::HTML(browser.html)
  end


  def self.scrape_weather(site)
    weather_options_array = []

    site.css("")

    weather_options_array
  end
end
