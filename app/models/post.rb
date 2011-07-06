class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  validates_presence_of :title, :body
  validate :user_id_is_present

  def is_author?(author)
    author && self.user == author
  end
  private

  def user_id_is_present
    raise "@post.user is nil" unless user
  end

end
