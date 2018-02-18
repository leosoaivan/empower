FactoryBot.define do
  factory :user do
    name { Faker::Witcher.character }
    username { (name[0] + name.split(" ").last).downcase }
    email { username + "@empower.org" }
    password { "foobar" }
    password_confirmation { "foobar" }
  end
end
