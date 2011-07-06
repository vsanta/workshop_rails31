require 'spec_helper'

describe "[Guests] Posts" do
  describe "when listed" do
    before(:each) do
      Factory.create(:post, :created_at => 10.days.ago)
      Factory.create(:post, :title => "another title")
    end
    it "should show more recent post first" do
      visit posts_path

      within "#posts" do
         within "tr:nth-child(2)" do
           page.should have_content "another title"
         end
         within "tr:nth-child(3)" do
           page.should have_content "First post"
         end

      end
    end
  end
  describe "on create" do
   it "should be redirected to sign in" do
     visit new_post_path

     page.current_path.should == new_user_session_path
     page.should have_content "You need to sign in or sign up before continuing."

   end
  end
end