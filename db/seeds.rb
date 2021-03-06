# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do
  User.create(firstname: Faker::Name.first_name,
              lastname: Faker::Name.last_name,
              address: Faker::Address.full_address,
              phone: Faker::PhoneNumber.cell_phone,
              dni: Faker::ChileRut.full_rut,
              email: Faker::Internet.free_email,
              password: Faker::Internet.password(8))
end

User.create(firstname: "Administrador",
  lastname: "Asistencias",
  address: Faker::Address.full_address,
  phone: Faker::PhoneNumber.cell_phone,
  dni: Faker::ChileRut.full_rut,
  email: "admin@email.com",
  password: "admin1234",
  role: "admin")

User.create(firstname: "Usuario",
  lastname: "Asistencias",
  address: Faker::Address.full_address,
  phone: Faker::PhoneNumber.cell_phone,
  dni: Faker::ChileRut.full_rut,
  email: "user@email.com",
  password: "user1234")