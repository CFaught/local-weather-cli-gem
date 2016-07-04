# require_relative "../local_weather.rb"
# require_relative "../../config/environment.rb"

class LocalWeather::Scraper
  # This class is the scraper used by the CLI class to pull
  # weather data in current, hourly, and 10 day forecasts from the
  # Weather Channel.com by zip code passed in from the CLI.
  extend Capybara::DSL

  def self.get_today(zip)
    visit "https://weather.com/weather/today/l/" + zip

    sleep(1)

    file_html = open("fixtures/weather_today.html", "w")
    file_html.write(page.html)
    file_html.close

  end

  def self.get_hourly(zip)

    visit "https://weather.com/weather/hourbyhour/l/" + zip

    sleep(1)

    file_html = open("fixtures/weather_hourly.html", "w")
    file_html.write(page.html)
    file_html.close

    page.html
  end


  def self.scrape_weather_today


    html = open("fixtures/weather_today.html").read
    doc = Nokogiri::HTML(html)

    puts
    temp = doc.css(".today_nowcard-temp").text.strip
    puts "#{temp[/\d+/].to_i}°F"
    puts doc.css(".today_nowcard-phrase").text
    precip_string = doc.css(".today-daypart-precip").text
    precip_arr = precip_string.split("\n").map! { |precip| precip.strip }
    precip_arr.reject! { |e| e.empty? }
    puts "#{precip_arr[0]} chance of precipitation."
    puts
  end

  def self.get_menu_options
    weather_options_array = []

    html = open("fixtures/weather.html").read
    doc = Nokogiri::HTML(html)


    weather_options_array
  end

  def self.quit_session
    page.driver.quit
  end
end

# site = LocalWeather::Scraper.get_site("76205")
# LocalWeather::Scraper.scrape_weather(site)
