FactoryGirl.define do
  factory :episode do
    petitioner_id ""
    respondent_id ""
    relationship ['dating/romantic/sexual','shared residence']
    victimization ['intimate partner violence']
    arrest false
    open true
  end
end
