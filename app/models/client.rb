class Client < ApplicationRecord
  has_many :petitioned_episodes, class_name: 'Episode', foreign_key: 'petitioner_id'

  has_many :responded_episodes, class_name: 'Episode', foreign_key: 'respondent_id'

  has_many :respondents, through: :petitioned_episodes
  has_many :petitioners, through: :responded_episodes

  def all_episodes
    self.petitioned_episodes.or(self.responded_episodes)
  end

  def self.search(params)
    if params[:id].to_i != 0
      name_and_id_search(params)
    elsif params[:firstname] || params[:lastname]
      name_search(params)
    else
      all
    end
  end

  private

  def self.name_search(params)
    where("lower(firstname) LIKE ? AND lower(lastname) LIKE ?", "%#{params[:firstname].downcase}%", "%#{params[:lastname].downcase}%")
  end

  def self.name_and_id_search(params)
    where("lower(firstname) LIKE ? AND lower(lastname) LIKE ? AND id = ?", "%#{params[:firstname].downcase}%", "%#{params[:lastname].downcase}%", params[:id])
  end

end
