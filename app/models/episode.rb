class Episode < ApplicationRecord
  belongs_to :petitioner, class_name: 'Client'
  belongs_to :respondent, class_name: 'Client', optional: true

  validates :relationship,  presence: true
  validates :victimization, presence: true
end