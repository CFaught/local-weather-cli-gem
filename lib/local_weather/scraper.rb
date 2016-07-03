require_relative "../local_weather.rb"
require_relative "../../config/environment.rb"

class LocalWeather::Scraper
  # This class is the scraper used by the CLI class to pull
  # weather data in current, hourly, and 10 day forecasts from the
  # Weather Channel.com by zip code passed in from the CLI.
  extend Capybara::DSL

  BASE_URL = "https://weather.com/weather/today/l/"

  def self.get_site(zip)

    visit BASE_URL + zip

    sleep(1)

    file_html = open("fixtures/weather.html", "w")
    file_html.write(page.html)
    file_html.close


    page.driver.quit
  end


  def self.scrape_weather(site)
    weather_options_array = []

    # doc = Nokogiri::HTML(site)
    html = open("fixtures/weather.html").read
    doc = Nokogiri::HTML(html)

    puts
    puts doc.css(".today_nowcard-temp").text.strip
    puts doc.css(".today_nowcard-phrase").text
    puts doc.css(".today-daypart-precip").text
    puts

    # weather_options_array
  end
end

# site = LocalWeather::Scraper.get_site("76205")
# LocalWeather::Scraper.scrape_weather(site)
