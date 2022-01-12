class CourseSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :icon, :max_users, :credits
end
