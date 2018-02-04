class Client < ApplicationRecord
  has_many :petitioned_episodes, class_name: 'Episode', foreign_key: 'petitioner_id'
  has_many :responded_episodes, class_name: 'Episode', foreign_key: 'respondent_id'
  has_many :respondents, through: :petitioned_episodes
  has_many :petitioners, through: :responded_episodes

  validates :firstname, presence: true
  validates :lastname,  presence: true

  def all_episodes
    self.petitioned_episodes.or(self.responded_episodes)
  end

  def mmddyyyy
    dob.strftime("%m/%d/%Y") unless dob.nil?
  end
end
