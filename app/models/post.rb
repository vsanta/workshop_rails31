class Post < ActiveRecord::Base
  has_many :comments
  has_many :attachments
  belongs_to :user
  before_save :do_geolocalization, :if => :location_changed?

  validates_presence_of :title, :body
  validate :user_id_is_present

  scope :recent, order("created_at DESC")
  accepts_nested_attributes_for :attachments, :reject_if => :all_blank

  def is_author?(author)
    author && self.user == author
  end
  private

  def user_id_is_present
    raise "@post.user is nil" unless user
  end

  def do_geolocalization
    self.lat, self.lng = Geocode.get(location) unless location.blank?
  rescue  Geocode::Error
    self.lat, self.lng = nil
  end

end
