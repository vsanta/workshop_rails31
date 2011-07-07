require "spec_helper"

describe "Geocode" do

  describe".get" do
    it "should return lat long for given location" do
       stub_geocode!("Rio de Janeiro, Brasil")
       Geocode.get("Rio de Janeiro, Brasil").should == [-22.9035393, -43.2095869]
    end
  end

  PLACES = { "Rio de Janeiro, Brasil" => File.read("spec/fixtures/rj.json")}

  def stub_geocode!(address)
    connection = Faraday::Connection.new do |b|
      b.adapter :test do |stubs|
        escaped_address = Faraday::Utils.escape address
        body = PLACES[address]
        url = "#{Geocode::PATH}?address=#{escaped_address}&sensor=false"
        stubs.get(url) { [200, { "Content-Type" => "json"}, body]}
      end
    end
    Faraday.default_connection = connection
  end
end