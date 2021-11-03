class Teacher < User
    has_one :teacher_profile, foreign_key: "user_id", dependent: :destroy
    accepts_nested_attributes_for :teacher_profile, update_only: true
    after_save :create_profile

    def create_profile
      self.create_teacher_profile! unless self.teacher_profile.present?
    end
end
