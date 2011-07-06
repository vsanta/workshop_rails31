class Attachment < ActiveRecord::Base
  belongs_to :post
  mount_uploader :attachment, AttachmentUploader
  validates_presence_of :name, :attachment

  def available_name
    name.presence || attachment_url
  end
end
