# frozen_string_literal: true

class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  CONTENT_TYPE = %w[image/jpeg image/gif image/png].freeze
  validates :image, content_type: { in: CONTENT_TYPE,
                                    message: 'must have a valid image format' },
                    size: { less_than: 5.megabytes,
                            message: 'should be less than 5MB' }

  # returns a resized image for display
  def display_image
    image.variant(resize_to_limit: [500, 500])
  end
end
