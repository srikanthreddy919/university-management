# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#create student role
unless User.find_by(email: "student@example.com")
  User.create(first_name: "Student", last_name: "Login", email: "student@example.com", role: :student, password: "password")
  p "Student created"
end
#create teacher role
unless User.find_by(email: "teacher@example.com")
  User.create(first_name: "Teacher", last_name: "Login", email: "teacher@example.com", role: :teacher, password: "password")
  p "Teacher created"
end
#create admin role
unless User.find_by(email: "admin@example.com")
  User.create(first_name: "Admin", last_name: "Login", email: "admin@example.com", role: :admin, password: "password")
  p "Admin created"
end