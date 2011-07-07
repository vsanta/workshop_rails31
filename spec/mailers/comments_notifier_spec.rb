require "spec_helper"

describe CommentsNotifier do
  describe "to_post_author" do
    let(:mail) { CommentsNotifier.to_post_author }

    it "renders the headers" do
      mail.subject.should eq("To post author")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
