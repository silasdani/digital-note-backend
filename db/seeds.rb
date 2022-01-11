# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

User.create!(
  first_name: 'Silas',
  last_name: 'Admin',
  email: 'admin@example.ro',
  password: 'password',
  password_confirmation: 'password'
)

User.create!(
  first_name: 'M',
  last_name: 'Manager',
  email: 'manager@example.ro',
  password: 'password',
  password_confirmation: 'password'
)

# Generate a bunch of additional users.
15.times do |n|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = "user#{n + 1}@example.com"
  password = 'password'
  User.create!(
    first_name: first_name,
    last_name: last_name,
    email: email,
    password: password,
    password_confirmation: password,
  )
end
