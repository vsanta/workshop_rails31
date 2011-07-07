require "faraday"

class Geocode
  HOST = "http://maps.googleapis.com"
  PATH = "/maps/api/geocode/json"
  URL = HOST+PATH


  # Same as
  #def self.get(address)
  #  instance.get(address)
  #end
  #
  #def self.instance
  #  @instance ||= new
  #end
  class << self
    delegate :get, :to => :instance

    private

    def instance
      @instance ||= new
    end

  end

  def get(address)
    response = get_response(address)
    puts response.body
    hash = parse_json(response.body)
    first = first_location(hash)
    [first["lat"], first["lng"]]
  end


  private

  def get_response(address)
    Faraday.default_connection.get do |request|
      request.url Geocode::URL, :address => address, :sensor => false
    end
  end

  #Install gem yajl-ruby for better json parsing performance
  def parse_json(body)
    ActiveSupport::JSON.decode body
  end

  def first_location(hash)
    results = hash["results"]
    results.first["geometry"]["location"]
  end
end