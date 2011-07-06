require 'spec_helper'

describe Attachment do
   describe "#available_name" do
    it "should return the url if no name is available" do
      attachment = Factory.build(:attachment, :name => "")
      attachment.available_name.should =~ %r(^/uploads/)
    end
    it "should return the name if available" do
      attachment = Factory.build(:attachment)
      attachment.available_name.should == "Rails Logo"
    end
  end
end
