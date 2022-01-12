class Course < ApplicationRecord
  resourcify
  belongs_to :user
end
