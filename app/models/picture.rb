class Picture < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  validates :image_or_content, presence: true
  attr_accessor :action_required

  private
  def image_or_content
    image.presence or content.presence
  end
end
