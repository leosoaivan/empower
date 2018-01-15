require 'database_cleaner'

DatabaseCleaner.clean_with(:truncation) if Rails.env.development?

user = User.create(
  name: "Leonard Soai-Van",
  username: "lsoaivan",
  email: "lsoaivan@empower.org",
  password: "testing",
  password_confirmation: "testing"
)

FactoryGirl.create_list(:client, 5)
FactoryGirl.create(:client, id: 44558, lastname: 'Smith-Lee-Buckner')

FactoryGirl.create(:episode, petitioner_id: '1', respondent_id: '2')
FactoryGirl.create(:episode, petitioner_id: '1', respondent_id: '3')
FactoryGirl.create(:episode, petitioner_id: '2', respondent_id: '1')

episode = Episode.first

5.times do
  episode.contacts.create(body: Faker::HarryPotter.quote, user_id: user.id)
end