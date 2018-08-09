class Client < ApplicationRecord
  resourcify

  scope :where_id, -> (id) { where(id: id) }
  scope :where_firstname_like, -> (firstname) { where('firstname ILIKE ?', "%#{firstname}%") }
  scope :where_lastname_like, -> (lastname) { where('lastname ILIKE ?', "%#{lastname}%") }
  
  has_many :petitioned_episodes, class_name: 'Episode', foreign_key: 'petitioner_id'
  has_many :responded_episodes, class_name: 'Episode', foreign_key: 'respondent_id' 

  has_many :respondents, through: :petitioned_episodes
  has_many :petitioners, through: :responded_episodes

  validates :firstname, presence: true
  validates :lastname,  presence: true

  def all_episodes
    self.petitioned_episodes.or(self.responded_episodes)
  end

  def self.chain_scopes_for_searching(scopes)
    scopes.delete_if { |key, value| value.blank? }

    return self.all if scopes.blank?

    Array(scopes).inject(self) do |object, array_of_scope_with_args|
      object.send(*array_of_scope_with_args)
    end
  end

  def fullname_and_dob
    if dob
      "#{firstname} #{lastname} - #{dob.strftime("%m/%d/%Y")}"
    else
      "#{firstname} #{lastname}"
    end 
  end
end