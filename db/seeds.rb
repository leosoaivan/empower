require 'database_cleaner'

DatabaseCleaner.clean_with(:truncation) if Rails.env.development?

# Create an intial guest
user = User.create(
  first_name: "User",
  last_name: "Tester",
  username: "utester",
  email: "utester@empower.org",
  password: "testing123"
)
user.add_role(:guest)

FactoryBot.create_list(:client, 5)
FactoryBot.create(:client, id: 44558, lastname: 'Smith-Lee-Buckner')

FactoryBot.create(:episode, petitioner_id: '1', respondent_id: '2')
FactoryBot.create(:episode, petitioner_id: '1', respondent_id: '3')
FactoryBot.create(:episode, petitioner_id: '2', respondent_id: '1')

episode = Episode.first

5.times do
  episode.contacts.create(body: Faker::HarryPotter.quote, user_id: user.id)
end

# Create all services
ALL_SERVICES = {
  "crisis" => [
    'dispatched on-call',
    'provided hotel',
    'provided shelter',
    'provided lock change',
    'provided ETPO'
  ],
  "medical" => [
    'provided info on DCFNE',
    'DCFNE conducted',
    'DCFNE declined'
  ],
  "supportive" => [
    'conducted safety plan',
    'provided info on CVC',
    'provided taxi',
    'referred to DVIC'
  ],
  "criminal justice" => [
    'provided general info on criminal system',
    'provided info on warrants or arrests',
    'provided info on filing violations'
  ],
  "civil justice" => [
    'provided general info on civil process',
    'provided info on service',
    'provided update to client'
  ],
  "general" => [
    "provided general info or update",
    "client declined all services",
    "client could not be reached"
  ]
}

class ServiceMaker
  def initialize(all_services)
    @all_services = all_services

    add_services_to_service_type
  end

  def add_services_to_service_type
    @all_services.each do |key, value|
      service_type = ServiceType.create(name: key)

      value.each do |service|
        service_type.services.create(name: service)
      end
    end
  end
end

ServiceMaker.new(ALL_SERVICES)