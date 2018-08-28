class FollowUp < ApplicationRecord
  belongs_to :user
  belongs_to :episode

  validates :due_by_date, presence: true
  validates :due_by_shift, presence: true
end
