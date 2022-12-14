class User < ApplicationRecord
  after_create :welcome_email
  has_many :comments, dependent: :destroy
  has_one_attached :avatar

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :omniauthable, omniauth_providers: [:google_oauth2]



  def full_name
    "#{first_name} #{last_name}"
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
        user = User.create(
           email: data['email'],
           password: Devise.friendly_token[0,20]
        )
    end
    user.first_name = access_token.info.first_name
    user.last_name = access_token.info.last_name
    user
  end

  private
  def welcome_email
    UserMailer.with(user: self).welcome_email.deliver_now
  end
end
