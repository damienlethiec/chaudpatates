class City < ApplicationRecord
  belongs_to :user
  has_many :sessions, dependent: :destroy
  has_many :trainings, dependent: :destroy

  alias_attribute :coach, :user
  alias_attribute :coach=, :user=

  validates :name, presence: true
  validates :photo, presence: true
  validates :user_id, presence: true

  has_attachment :photo
end
