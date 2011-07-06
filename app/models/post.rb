class Post
  include Mongoid::Document
  attr_accessible :title, :body

  field :title, :type => String
  field :body, :type => String
  
  validates_presence_of :title, :body

  embeds_many :comments
end
