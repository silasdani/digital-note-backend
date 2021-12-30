# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :teacher_profile
  validates_uniqueness_of :teacher_profile_id, scope: :user_id
  validates :comment, presence: true, length: { minimum: 5 }
end
