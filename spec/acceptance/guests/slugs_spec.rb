require "spec_helper"

describe "[Guest] Posts slugs" do
  before(:each) do
    @post = Factory.create :post, :slug=>"abcd"
  end
  it "should redirect based on /r/* slugs" do
    visit "/r/#{@post.slug}"
    page.should have_content @post.title

    expect{
      visit "/r/unknown"
    }.to raise_error ActionController::RoutingError

  end
  it "should redirect based on /m/* slugs" do
    visit "/m/#{@post.slug}"
    page.should have_content @post.title

    expect{
      visit "/m/unknown"
    }.to raise_error ActiveRecord::RecordNotFound

  end
end