FactoryBot.define do
  factory :user do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    address { Faker::Address.full_address }
    phone { Faker::PhoneNumber.cell_phone }
    dni { Faker::ChileRut.full_rut }
    email 'foo@bar.com'
    password 'foobar'
  end
end