require "spec_helper"

describe "Geocode" do

  describe".get" do
    it "should return lat long for given location" do
       stub_geocode!("Rio de Janeiro, Brasil")
       Geocode.get("Rio de Janeiro, Brasil").should == [-22.9035393, -43.2095869]
    end

    it "should return nil and nil if address is blank" do
       Geocode.get("").should == [nil,nil]
    end
    it "should return nil and nil if address is unknown" do
      stub_geocode!("unknown location")
      Geocode.get("unknown location").should == [nil,nil]
    end

    it "should raise an error if result is not 200" do
      stub_geocode!("Rio de Janeiro, Brasil", 500)
      begin
        Geocode.get("Rio de Janeiro, Brasil")
        raise "An exception should have been raised"
      rescue Geocode::Error => e
        e.status.should == 500
        e.message.should == "[Geocode] for \"Rio de Janeiro, Brasil\" failed with status 500"
      end
    end
  end
end