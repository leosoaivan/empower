class Contact < ApplicationRecord
  belongs_to :user
  belongs_to :episode

  validates :body, presence: true
end
