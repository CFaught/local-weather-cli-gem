require "nokogiri"
require "open-uri"
require "phantomjs"
require "watir"

class LocalWeather::Scraper
  # This class is the scraper used by the CLI class to pull
  # weather data in current, hourly, and 10 day forecasts from the
  # Weather Channel.com by zip code passed in from the CLI.

  BASE_URL = "https://weather.com/weather/today/l/"

  def self.get_site(zip)
    browser = Watir::Browser.new(:phantomjs)
    browser.goto BASE_URL + zip
    # html = open(BASE_URL + zip)
    doc = Nokogiri::HTML(browser.html)
  end


  def self.scrape_weather(site)
    weather_options_array = []

    site.css("")

    weather_options_array
  end
end
