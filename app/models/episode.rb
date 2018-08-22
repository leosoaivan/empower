class Episode < ApplicationRecord
  resourcify
  
  belongs_to :petitioner, class_name: 'Client'
  belongs_to :respondent, class_name: 'Client', optional: true

  accepts_nested_attributes_for :respondent, reject_if: :all_blank

  validates :relationship,  presence: true
  validates :victimization, presence: true

  has_many :contacts, -> { order(created_at: :desc) }, dependent: :destroy

  scope :desc_order, -> { order(created_at: :desc) }

  def respondent_fullname
    respondent.try(:fullname_and_dob)
  end
  
  def respondent_fullname=(fullname)
    if fullname.present?
      respondent_names = fullname.split(' ')
      first_name = respondent_names[0]
      last_name = respondent_names[1..-1].join(' ')
      self.respondent = Client.find_or_create_by(first_name: first_name,
                                                 last_name: last_name)
    end
  end
end