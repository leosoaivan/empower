FactoryGirl.define do
  factory :client do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    dob { Faker::Date.birthday(18, 65) }
    telephone { Faker::PhoneNumber.cell_phone }
    address { 
      { street: Faker::Address.street_address,
        secondary: Faker::Address.secondary_address,
        city: Faker::Address.city,
        state: Faker::Address.state_abbr,
        zipcode: Faker::Address.zip 
      }
    }
    children { rand(0..10) }
    gender "Female"
    email { Faker::Internet.email}
  end
end
