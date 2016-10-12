class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:linkedin]

  has_one :city
  has_many :bookings, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :is_coach, inclusion: { in: [true,false] }
  validates :tickets_nb, presence: true, numericality: { only_integer: true }

  has_attachment :photo

  def self.find_for_linkedin_oauth(auth)
    user_params = auth.slice(:provider, :uid).to_h
    user_params.merge! auth.info.slice(:email, :first_name, :last_name, :headline)
    user_params[:linkedin_picture_url] = auth.info.image
    user_params[:linkedin_summary] = auth.extra.raw_info.summary
    user_params[:linkedin_profile] = auth.info.urls.public_profile
    user_params[:token] = auth.credentials.token
    user = User.where(provider: auth.provider, uid: auth.uid).first
    user ||= User.where(email: auth.info.email).first # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save
    end
    return user
  end


  def to_s
    self.email
  end
end
