class Service < ApplicationRecord
  belongs_to :service_type
  has_and_belongs_to_many :contacts

  validates :name, presence: true
end
