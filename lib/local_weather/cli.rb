require_relative "../local_weather.rb"
require "colorize"

class LocalWeather::CLI
  attr_accessor :data

  def call
    puts "Enter your local zip code to check weather: ".green
    zip = get_zip
    puts "here is your zip: #{zip}"
    scrape(zip)
    menu
  end

  def scrape(zip_code)
    # get scraped data from site and return hash?
    doc = LocalWeather::Scraper.get_site(zip_code)
    @data = ["current weather", "3 day forecast", "hourly"]
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

  def menu
    input = nil
    while input != "exit" && input != "quit"
      puts "Enter option for more detail: "
      self.data.each_with_index do |option, index|
        puts "#{index + 1}. #{option}"
      end
      input = gets.chomp.downcase

      case input
      when "1"
        puts "Current local weather"
        puts "Temp: 91°F"
        puts "Humidity: 60%"
        puts "Chance of Precipitation: 35%"
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
