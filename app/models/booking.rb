class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :training

  validates :user_id, presence: true
  validates :training_id, presence: true
end
