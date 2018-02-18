class Episode < ApplicationRecord
  belongs_to :petitioner, class_name: 'Client'
  belongs_to :respondent, class_name: 'Client', optional: true

  accepts_nested_attributes_for :respondent, reject_if: :all_blank

  validates :relationship,  presence: true
  validates :victimization, presence: true

  has_many :contacts
end