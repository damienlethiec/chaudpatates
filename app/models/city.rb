class City < ApplicationRecord
  belongs_to :user
  has_many :sessions, dependent: :destroy
  has_many :trainings, dependent: :destroy

  alias_attribute :user, :coach

  validates :name, presence: true
  validates :user_id, presence: true
end
