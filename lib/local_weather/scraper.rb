# require_relative "../local_weather.rb"
# require_relative "../../config/environment.rb"

class LocalWeather::Scraper
  # This class is the scraper used by the CLI class to pull
  # weather data in current, hourly, and 10 day forecasts from the
  # Weather Channel.com by zip code passed in from the CLI.
  extend Capybara::DSL

  def self.get_site_html(zip)
    puts "Retrieving data, this may take a minute..."
    visit "https://weather.com/weather/today/l/" + zip

    sleep(2)

    self.save_html("weather_today.html")

    visit "https://weather.com/weather/hourbyhour/l/" + zip

    sleep(2)

    self.save_html("weather_hourly.html")

    visit "https://weather.com/weather/tenday/l/" + zip

    sleep(2)

    self.save_html("weather_ten_day.html")
  end

  def self.save_html(filename)
    file_html = open("fixtures/" + filename, "w")
    file_html.write(page.html)
    file_html.close
  end

  def self.scrape_weather_today
    html = open("fixtures/weather_today.html").read
    doc = Nokogiri::HTML(html)

    puts
    temp = doc.css(".today_nowcard-temp").text.strip
    puts "Current Temp: #{temp[/\d+/].to_i}°F"
    puts "Current Condition: " + doc.css(".today_nowcard-phrase").text
    puts "Feels like: " + doc.css(".today_nowcard-feels").text.split("\n").map! { |e| e.strip }[2]
    puts "Hi/Low: " + doc.css(".today_nowcard-hilo").text.split("\n").map! { |e| e.strip }.join(" ")
    precip_string = doc.css(".today-daypart-precip").text
    precip_arr = precip_string.split("\n").map! { |precip| precip.strip }
    precip_arr.reject! { |e| e.empty? }
    puts "#{precip_arr[0]} chance of precipitation."
    table_data = doc.css("table tr").text.split("\n").map! { |e| e.strip }.join(" ")
    puts table_data
    puts
  end

  def self.scrape_weather_hourly
    html = open("fixtures/weather_hourly.html").read
    doc = Nokogiri::HTML(html)

    descriptions = doc.css("tbody td.description").text.split("\n").map! { |e| e.strip }
    times = doc.css("tbody td span.time-detail").text.split("\n").map! { |e| e.strip }
    temps = doc.css("tbody td.temp").text.split("\n").map! { |e| e.strip }
    feels = doc.css("tbody td.feels").text.split("\n").map! { |e| e.strip }
    precips = doc.css("tbody td.precip").text.split("\n").map! { |e| e.strip }
    humidities = doc.css("tbody td.humidity").text.split("\n").map! { |e| e.strip }
    winds = doc.css("tbody td.wind").text.split("\n").map! { |e| e.strip.gsub("mph", "") }

    puts
    puts "Times        |" + times.join("   ")
    puts "______________________________________________________________"
    puts "Tempurature  |" + temps.join("   ")
    puts "Real Feel    |" + feels.join("   ")
    puts "Condition    |" + descriptions.join("  ")
    puts "Precipitation|" + precips.join("  ")
    puts "Humidity     |" + humidities.join("   ")
    puts "Wind(mph)    |" + winds.join(" ")
    puts
  end

  def self.scrape_weather_ten_day
    html = open("fixtures/weather_ten_day.html").read
    doc = Nokogiri::HTML(html)

    days = doc.css("header.weather-cell h2").collect { |e| e.text }
    days.map! { |e| e.length == 5 ? e  : e + "  " }
    hi_temps = doc.css("p.temp span.hi-temp").collect { |e| e.text.strip.gsub("F", "") }
    lo_temps = doc.css("p.temp span.lo-temp").collect { |e| e.text.strip.gsub("F", "") }
    phrases = doc.css("h3.weather-phrase span.phrase").collect { |e| e.text }
    precips = doc.css("section.wxcard p.weather-cell span.precip-val").collect { |e| e.text }
    winds = doc.css("p.wind-conditions span.wx-wind").collect { |e| e.text }
    humidities = []
    doc.css("section.wxcard p.humidity span").collect { |e| e.text }.each_with_index do |e, index|
      if index % 3 == 0
        humidities << e
      end
    end


    # days.each do |day|
    #   puts day
    #   puts
    # end
    puts
    puts "DAY   |  HI/LO  |  CONDITION  | PRECIP | WIND | HUMIDITY"
    10.times do |i|
      puts "#{days[i]} | #{hi_temps[i]}/#{lo_temps[i]} | #{phrases[i]} |  #{precips[i]}  | #{winds[i]} | #{humidities[i]}"
    end
  end

  def self.quit_session
    page.driver.quit
  end
end

# site = LocalWeather::Scraper.get_site("76205")
# LocalWeather::Scraper.scrape_weather(site)
