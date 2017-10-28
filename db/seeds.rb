require 'database_cleaner'

DatabaseCleaner.clean_with(:truncation)

user = User.create(
  name: "Leonard Soai-Van",
  username: "lsoaivan",
  email: "lsoaivan@empower.org",
  password: "testing",
  password_confirmation: "testing"
)

FactoryGirl.create_list(:client, 5)

FactoryGirl.create(:episode, petitioner_id: '1', respondent_id: '2')
FactoryGirl.create(:episode, petitioner_id: '1', respondent_id: '3')
FactoryGirl.create(:episode, petitioner_id: '2', respondent_id: '1')