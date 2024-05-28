class User < ApplicationRecord
  SYSTEM_USER_EMAIL = "ai@landingburn.com"

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable
  # :registerable, :recoverable and :validatable
  devise :database_authenticatable, :rememberable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :user_assistables
  has_many :assistants, through: :user_assistables, source: :assistable, source_type: "Assistant"
  has_many :pipelines, through: :user_assistables, source: :assistable, source_type: "Pipeline"
  has_many :user_chats, dependent: :destroy
  has_many :chats, through: :user_chats, source: :chat
  has_many :messages, dependent: :destroy

  def assistables
    user_assistables.map(&:assistable)
  end

  def human?
    email != SYSTEM_USER_EMAIL
  end

  def self.from_omniauth(auth)
    # Confusingly, this will set provider and remote_id to the queried values, as well as the other attributes on create.
    # See keredson's explanation here: https://apidock.com/rails/ActiveRecord/Relation/first_or_create
    where(provider: auth.provider, remote_id: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.full_name = auth.info.name # assuming the user model has a name
      user.avatar_url = auth.info.image # assuming the user model has an image
    end
  end

  def self.system
    find_by_email(SYSTEM_USER_EMAIL) || create(
      email: SYSTEM_USER_EMAIL,
      password: Devise.friendly_token[0, 20],
      full_name: "LandingBurn AI"
    )
  end
end
