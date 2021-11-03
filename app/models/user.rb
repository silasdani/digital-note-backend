class User < ApplicationRecord
  has_and_belongs_to_many :subjects
  has_and_belongs_to_many :meeting_locations
  has_and_belongs_to_many :study_levels
  has_many :reviews, dependent: :destroy
  #has_one :student_profile, dependent: :destroy
  #has_one :teacher_profile, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable      
  
  def student?
    %w(Student).include? type
  end

  def teacher?
    %w(Teacher).include? type
  end
end
