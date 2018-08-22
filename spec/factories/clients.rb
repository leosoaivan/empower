FactoryBot.define do
  factory :client, aliases: [:petitioner, :respondent] do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end

  factory :client_with_episodes, parent: :client do
    after(:create) do |client, evaluator|
      create_list(:episode, 2, petitioner: client)
    end
  end
end
