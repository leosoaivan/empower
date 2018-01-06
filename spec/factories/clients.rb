FactoryGirl.define do
  factory :client, aliases: [:petitioner, :respondent] do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
  end

  factory :client_with_episodes, parent: :client do
    after(:create) do |client, evaluator|
      create_list(:episode, 2, petitioner: client)
    end
  end
end
