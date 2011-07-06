require 'spec_helper'

describe "Attachment" do
  before(:each) do
    @user = Factory.create(:user)
    #using password form 'raw' factory so it wont be encrypted
    sign_user_in_manually(@user, Factory(:user).password)
  end
  describe "on create" do
    it "should succeed if valid data for the post and  attachment is provided" do
      visit new_post_path

      fill_in "Title", :with => "First post"
      fill_in "Body", :with => "very short post"

      within ".attachment_form:nth-child(1)" do
        fill_in "Name", :with => "Rails logo"
        attach_file "Attachment", "spec/fixtures/rails.png"
      end

      click_button "Create Post"
      page.should have_content  "First post"

      click_link "Rails logo"
      page.current_path.should == %r(/uploads/attachment/attachment/\+d/rails\.png)
   end
  end
end