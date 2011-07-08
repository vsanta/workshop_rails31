require 'spec_helper'

describe "[Users] Posts" do
  before(:each) do
    @user = Factory.create(:user)
    #using password form 'raw' factory so it wont be encrypted
    sign_user_in_manually(@user, Factory(:user).password)
  end
  describe "on create" do
    # send a hash after "it" to specify driver. Ex:  :driver => :selenium
    it "should succeed" do
      visit posts_path
      click_link "New Post"

      fill_in "Title", :with => "First post"
      fill_in "Body", :with => "very short post"
      fill_in "Slug", :with => "slug_abc"
      click_button "Create Post"

      page.should have_content "First post"
      page.should have_content  "very short post"
      page.should have_content  "slug_abc"

    end

    it "should fail if invalid data is provided" do
      visit new_post_path

      click_button "Create Post"

      page.should have_content "Some errors were found, please take a look:"
    end
  end

  describe "on update" do
    before(:each) do
      @post = Factory.create(:post, :user=> @user)
    end
    it "should succeed" do
      visit edit_post_path @post

      fill_in "Title", :with => "another post"
      fill_in "Body", :with => "another very short post"
      click_button "Update Post"

      page.should have_content "another post"
      @post.reload.body.should == "another very short post"
    end

    describe "works only for post author" do
      before(:each) do
         @another_post = Factory.create(:post)
      end
      it "should not allow direct url access" do
        expect {
          visit edit_post_path @another_post
        }.to raise_error ActiveRecord::RecordNotFound
      end
      it "should not have edit link on post show" do
        visit post_path  @another_post
        page.should have_content "Edit"
      end
      it "should not have edit link on post list" do
        visit posts_path
        # accessing the post @post created by @user.
        within @post do
          page.should have_content "Edit"
          page.should have_content "Destroy"
        end
        #post by someonelse
        within @another_post do
          page.should have_no_content "Edit"
          page.should have_no_content "Destroy"
        end
      end

    end
  end
end
