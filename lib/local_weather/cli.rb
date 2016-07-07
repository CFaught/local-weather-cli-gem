# require_relative "../local_weather.rb"

class LocalWeather::CLI
  # This is the CLI class that acts as the menu and asks for a zip code
  # to scrape the weather data from Weather Channel using LocalWeather::Scraper
  # the main entry point for the program used by the executable in bin/local_weather
  # is LocalWeather::CLI.new.call

  attr_accessor :data

  def initialize
    @data = ["Current Weather", "Hourly", "10 Day Forecast", "Update Data/Check Different Zip"]
  end

  def call
    welcome_screen
    zip = get_zip
    LocalWeather::Scraper.get_site_html(zip)
    menu(zip)

    LocalWeather::Scraper.quit_session
  end

  def welcome_screen
    puts
    puts
    puts "Local Weather Forecast powered by Ruby!"
    puts "Enter your local zip code to check weather: "
    puts
  end

  def get_zip
    input = gets.chomp

    if input.downcase == "exit" || input.downcase == "quit"
      input = "00000"
    elsif input.length != 5 || input !~ /^(?<num>\d+)$/
      puts "Please enter a valid zip code: ".red
      self.get_zip
    end
    input
  end

  def menu(zip_code)
    input = nil
    while input != "exit" && input != "quit"
      puts "Enter option for more detail: "
      puts
      self.data.each_with_index do |option, index|
        puts "#{index + 1}. #{option}"
      end
      puts
      input = gets.chomp.downcase

      case input
      when "1"
        puts
        puts "Current local weather for #{zip_code}"
        puts
        LocalWeather::Scraper.scrape_weather_today
      when "2"
        puts
        puts "Hourly forecast for #{zip_code}"
        puts
        LocalWeather::Scraper.scrape_weather_hourly
      when "3"
        puts
        puts "10 day forecast for #{zip_code}"
        puts
        LocalWeather::Scraper.scrape_weather_ten_day
      when "4"
        puts
        puts "Enter zip code: "
        zip_code = gets.chomp
        puts
        LocalWeather::Scraper.get_site_html(zip_code)
      end
    end
  end
end
