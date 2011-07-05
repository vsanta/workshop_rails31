class Post
  include Mongoid::Document
  attr_accessible :title, :body

  field :title, :type => String
  field :body, :type => String

  embeds_many :comments
end
