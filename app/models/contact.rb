class Contact < ApplicationRecord
  belongs_to :user
  belongs_to :episode
  has_and_belongs_to_many :services

  validates :body, presence: true
end