require 'spec_helper'

describe "[Guests] Comments" do
  before :each do
    @post = Factory(:post)
  end
  describe "on create" do
    before(:each) do
      visit post_path  @post
    end
    it "should send email to author" do
      fill_in "My comment", :with => "My First comment"
      expect{
        click_button "Create Comment"
      }.to change(ActionMailer::Base.deliveries, :size).by(1)

      mail = ActionMailer::Base.deliveries.last
      mail.to.should == [@post.user.email]

    end
    describe "with valid data" do
      before(:each) do
        fill_in "My comment", :with => "My First comment"
        click_button "Create Comment"
      end
      let :success_message do
        "Your comment was successfully added to the post"
      end
      it "should succeed" do
        page.should have_content success_message
        page.should have_content "My First comment"
        page.current_path.should ==  post_path(@post)
      end
      it "should succeed with ajax", :js=>true do
        within @post.comments.last do
          page.should have_content "My First comment"
        end
        page.should have_no_content success_message
        page.should have_css "#new_comment textarea", :text=>""
      end
    end
    describe "with invalid data" do
      let :error_message do
        "Some errors were found, please take a look:"
      end

      it "should fail" do
        click_button "Create Comment"
        page.should have_content error_message
        page.current_path.should ==  post_comments_path(@post)
      end
      it "should fail with ajax", :js=>true do
        click_button "Create Comment"
        page.current_path.should ==  post_path(@post)
        page.should have_content error_message
      end
    end


  end
end