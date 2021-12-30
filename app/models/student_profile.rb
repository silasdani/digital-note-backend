# frozen_string_literal: true

class StudentProfile < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
end
