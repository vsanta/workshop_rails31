class Comment
  include Mongoid::Document
  attr_accessible :body

  field :body, :type => String

  embedded_in :post
end
