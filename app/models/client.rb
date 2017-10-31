class Client < ApplicationRecord
  has_many :petitioned_episodes, class_name: 'Episode', foreign_key: 'petitioner_id'

  has_many :responded_episodes, class_name: 'Episode', foreign_key: 'respondent_id'

  has_many :respondents, through: :petitioned_episodes
  has_many :petitioners, through: :responded_episodes

  def all_episodes
    self.petitioned_episodes.or(self.responded_episodes)
  end

  def self.search(params)
    if params[:firstname] || params[:lastname]
      where("lower(firstname) LIKE ? AND lower(lastname) LIKE ?", "#{params[:firstname].downcase}%", "#{params[:lastname].downcase}%")
    else
      all
    end
  end

end
