# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


subjects = Subject.create!([{title:"Matematica", category: "Stiinte reale"},
    {title:"Informatica", category: "Stiinte reale"},
    {title:"Limba engleza", category: "Limba si literatura"},
    {title:"Limba romana", category: "Limba si literatura"},
    {title:"Fizica", category: "Stiinte reale"}])

locations = MeetingLocation.create!([{name:"Online"},
                            {name:"Domiciliul elevului"},
                            {name:"Domiciliul profesorului"}])

levels = StudyLevel.create!([{name: "Gradinita"},
                          {name: "Generala I-IV"},
                          {name: "Gimnaziu V-VIII"},
                          {name: "Pregatire Evaluarea Nationala"},
                          {name: "Pregatire Bacalaureat"},
                          {name: "Admitere Facultate"}])


s = Student.create!(email: 'student@example.com',
  name: 'Student',
  password: 'password',
  password_confirmation: 'password',
  subjects: [subjects[0], subjects[1]],
  meeting_locations: [locations[0],locations[1]],
  study_levels: [levels[2],levels[3]])

s.create_student_profile!(school:'UTCN, Faculty of Computer Science',
  date_of_birth: '1980-03-02')



t = Teacher.create!(email: 'teacher@example.com',
  name: 'Teacher',
  password: 'password',
  password_confirmation: 'password',
  subjects: [subjects[0], subjects[1]])

t.create_teacher_profile!(education:"Babes Boylai Faculty of Mathematics and Computer Science",
  exp_years: 20,
  price: 70,
  date_of_birth: '1980-03-02')

if Rails.env.development?
    AdminUser.create!(email: 'admin@example.com',
    password: 'password',
    password_confirmation: 'password')

    30.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@domain.com"
    password = "password"
    education =  Faker::University.name
    date_of_birth = Faker::Date.between(from: '1975-01-01', to: '1999-01-01')
    price = Faker::Number.between(from: 3, to: 10)*10
    exp_years = ((Time.zone.now - date_of_birth.to_time) / 1.year.seconds).floor - 20
    snr = Faker::Number.between(from: 0, to: 4)
    city = Faker::Address.city
    t = Teacher.create!(name: name,
        email: email,
        password: password,
        password_confirmation: password,
        subjects: [subjects[snr]],
        meeting_locations: [locations[0]],
        study_levels: [levels[snr]])

    t.create_teacher_profile!(education: education,
        exp_years: exp_years,
        price: price,
        date_of_birth: date_of_birth,
        city: city)


    end
end