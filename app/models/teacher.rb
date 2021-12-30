# frozen_string_literal: true

class Teacher < User
  has_one :teacher_profile, foreign_key: 'user_id', dependent: :destroy
  accepts_nested_attributes_for :teacher_profile, update_only: true
  after_save :create_profile

  def create_profile
    create_teacher_profile! unless teacher_profile.present?
  end
end
