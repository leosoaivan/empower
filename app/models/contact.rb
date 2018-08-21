class Contact < ApplicationRecord
  resourcify
  
  belongs_to :user
  belongs_to :episode
  has_and_belongs_to_many :services

  validates :body, presence: true

  scope :desc, -> { order(created_at: :desc) }
end