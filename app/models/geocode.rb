require "faraday"

class Geocode
  HOST = "http://maps.googleapis.com"
  PATH = "/maps/api/geocode/json"
  URL = HOST+PATH

  class Error < StandardError
    attr_accessor :address, :status

    def initialize(address, status)
      @address = address
      @status = status
      super("[Geocode] for \"#{@address}\" failed with status #{@status}")
    end
  end

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
    return [nil,nil] if address.blank?
    response = get_response(address)
    check_status address, response.status
    hash = parse_json(response.body)
    first = first_location(hash)
    [first["lat"], first["lng"]]
  end


  private

  def check_status address, status
    unless status == 200
      error = Geocode::Error.new(address, status)
      Rails.logger.error error.message
      raise  error
    end
  end

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
    return {} if results.empty?
    results.first["geometry"]["location"]
  end
end