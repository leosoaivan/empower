class FollowUp < ApplicationRecord
  belongs_to :user
  belongs_to :episode

  enum due_by_shift: { morning: 1, afternoon: 2, evening: 3, overnight: 4 }

  validates :due_by_date, presence: true
  validates :due_by_shift, presence: true
end
