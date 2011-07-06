class Comment
  include Mongoid::Document
  attr_accessible :body

  field :body, :type => String
  validates_presence_of :body
  embedded_in :post
end
