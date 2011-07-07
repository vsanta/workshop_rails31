class Comment < ActiveRecord::Base
  before_create :send_post_to_author
  belongs_to :post
  validates_presence_of :body

  private

  def send_post_to_author
    CommentsNotifier.to_post_author(self).deliver
  end
end
