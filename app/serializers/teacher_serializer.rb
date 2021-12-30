# frozen_string_literal: true

class TeacherSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :email,
             teacher_profile_attributes: %i[education reviews exp_years price meeting_duration_in_minutes desc date_of_birth city image]
end
