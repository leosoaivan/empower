FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    username { (first_name[0] + last_name).downcase }
    email { username + "@empower.org" }
    password { "foobar" }
    password_confirmation { "foobar" }

    factory :admin do
      after(:create) { |user| user.add_role :admin }
    end

    factory :staff do
      after(:create) { |user| user.add_role :staff }
    end

    factory :guest do
      after(:create) { |user| user.add_role :guest }
    end
  end
end
