FactoryBot.define do
  factory :episode do
    petitioner
    respondent
    relationship ['dating/romantic/sexual','shared residence']
    victimization ['intimate partner violence']
  end
end
