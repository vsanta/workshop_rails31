require 'spec_helper'

describe "Posts" do
  describe "on create" do
    # send a hash after "it" to specify driver. Ex:  :driver => :selenium
    it "should succeed" do
      visit posts_path
      click_link "New Post"

      fill_in "Title", :with => "First post"
      fill_in "Body", :with => "very short post"
      click_button "Create Post"

      page.should have_content "First post"
      page.should have_content  "very short post"

    end

    it "should fail if invalid data is provided" do
      visit new_post_path

      click_button "Create Post"

      page.should have_content "Some errors were found, please take a look:"
    end
  end
end
