class Episode < ApplicationRecord
  resourcify
  
  belongs_to :petitioner, class_name: 'Client'
  belongs_to :respondent, class_name: 'Client', optional: true

  accepts_nested_attributes_for :respondent, reject_if: :all_blank

  validates :relationship,  presence: true
  validates :victimization, presence: true

  has_many :contacts, -> { order(created_at: :desc) }, dependent: :destroy

  scope :desc_order, -> { order(created_at: :desc) }

  def respondent_name
    respondent.try(:firstname).try(:lastname)
  end
  
  def respondent_name=(firstname, lastname)
    byebug
    self.respondent = Client.find_by(firstname: firstname, lastname: lastname)
  end
end