require_relative "../local_weather.rb"
class LocalWeather::CLI

  def call
    puts "Enter your local zip code to check weather: "
    zip = get_zip
    puts "here is your zip: #{zip}"
  end

  def scrape

  end

  def get_zip
    input = gets.chomp

    if input.length != 5 || input !~ /^(?<num>\d+)$/
      puts "Please enter a valid zip code: "
      self.get_zip
    end
    input
  end
end
