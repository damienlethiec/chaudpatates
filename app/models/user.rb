class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :city
  has_many :bookings, dependent: :destroy

  # validates :first_name, presence: true
  # validates :last_name, presence: true
  validates :is_coach, inclusion: { in: [true,false] }
  validates :tickets_nb, presence: true, numericality: { only_integer: true }

  has_attachment :photo
  
  def to_s
    self.email
  end
end
