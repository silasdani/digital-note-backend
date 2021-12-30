# frozen_string_literal: true

class Student < User
  has_one :student_profile, foreign_key: 'user_id', dependent: :destroy
  accepts_nested_attributes_for :student_profile, update_only: true
  after_save :create_profile

  def create_profile
    create_student_profile! unless student_profile.present?
  end
end
