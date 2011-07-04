require 'spec_helper'

describe "Comments" do
  before :each do
    @post = Factory(:post)
  end
  describe "on create" do
    it "should work" do
      visit post_path  @post

      fill_in "My comment", :with => "My First comment"
      click_button "Create Comment"

      page.should have_content "Your comment was successfully added to the post"
      page.should have_content "My First comment"
      page.current_path.should ==  post_path(@post)
    end
  end
end