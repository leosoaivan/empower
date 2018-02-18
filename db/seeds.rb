require 'database_cleaner'

DatabaseCleaner.clean_with(:truncation) if Rails.env.development?

user = User.create(
  name: "Leonard Soai-Van",
  username: "lsoaivan",
  email: "lsoaivan@empower.org",
  password: "testing",
  password_confirmation: "testing"
)

FactoryBot.create_list(:client, 5)
FactoryBot.create(:client, id: 44558, lastname: 'Smith-Lee-Buckner')

FactoryBot.create(:episode, petitioner_id: '1', respondent_id: '2')
FactoryBot.create(:episode, petitioner_id: '1', respondent_id: '3')
FactoryBot.create(:episode, petitioner_id: '2', respondent_id: '1')

episode = Episode.first

5.times do
  episode.contacts.create(body: Faker::HarryPotter.quote, user_id: user.id)
end