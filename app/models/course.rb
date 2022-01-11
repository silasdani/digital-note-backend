class Course < ApplicationRecord
    resourcify
    belongs_to :users
end
