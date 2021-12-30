# frozen_string_literal: true

class TeacherProfile < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :reviews
  has_many :users, through: :reviews
  validates :user_id, presence: true
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
                                    message: 'must be a valid image format' },
                    size: { less_than: 5.megabytes,
                            message: 'should be less than 5MB' }

  def display_image(size)
    if image.attached?
      image.variant(resize_to_limit: [size, size])
    else
      'default.png'
    end
  end
end
