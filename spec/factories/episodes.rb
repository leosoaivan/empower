FactoryGirl.define do
  factory :episode do
    petitioner_id 1
    respondent_id 1
    relationship ['dating/romantic/sexual','shared residence']
    victimization ['intimate partner violence']
    arrest false
    open true
  end
end
