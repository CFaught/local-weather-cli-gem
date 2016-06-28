require "nokogiri"
require "open-uri"

class LocalWeather::Scraper
  BASE_URL = "https://weather.com/weather/today/l/"

  def self.get_site(zip)
    html = open(BASE_URL + zip)
    doc = Nokogiri::HTML(html)
  end
end
