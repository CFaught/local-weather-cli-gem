# require_relative "../local_weather.rb"

class LocalWeather::CLI
  # This is the CLI class that acts as the menu and asks for a zip code
  # to scrape the weather data from Weather Channel using LocalWeather::Scraper
  # the main entry point for the program used by the executable in bin/local_weather
  # is LocalWeather::CLI.new.call

  attr_accessor :data

  def initialize
    @data = ["current weather", "hourly", "10 day forecast"]
  end

  def call
    welcome_screen
    zip = get_zip
    menu(zip)

    LocalWeather::Scraper.quit_session
  end

  def welcome_screen
    puts
    puts
    puts "Local Weather Forecast powered by Ruby!".green
    puts "Enter your local zip code to check weather: ".green
  end

  # def scrape_today(zip_code)
  #   # get scraped data from site and return hash?
  #   LocalWeather::Scraper.get_today(zip_code)
  #   LocalWeather::Scraper.scrape_weather
  # end

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
      self.data.each_with_index do |option, index|
        puts "#{index + 1}. #{option}"
      end
      input = gets.chomp.downcase

      case input
      when "1"
        LocalWeather::Scraper.get_today(zip_code)
        puts
        puts
        puts "Current local weather for #{zip_code}"
        puts
        LocalWeather::Scraper.scrape_weather_today
      when "2"
        puts "3 day forecast"
        puts "Monday: Partly Cloudy, 34% chance of precipitation"
        puts "Tuesday: Clear, 10% chance of precipitation"
        puts "Wednesday: Thunderstorms, 80% chance of precipitation"
      when "3"
        puts "Hourly forecast"
        puts "1200: Partly Cloudy, 34% chance of precipitation"
        puts "1300: Clear, 10% chance of precipitation"
        puts "1400: Thunderstorms, 80% chance of precipitation"

      end
    end
  end
end
