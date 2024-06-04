class User < ApplicationRecord
  include AI::Engine::Chattable
  include ActionView::RecordIdentifier

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable
  # :registerable, :recoverable and :validatable
  devise :database_authenticatable, :rememberable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :storytellers, dependent: :destroy

  def on_assistant_thread_message_create(message:)
    broadcast_ai_response(message:)
  end

  def on_ai_response(message:)
    broadcast_ai_response(message:)
  end

  def broadcast_ai_response(message:)
    broadcast_append_to(
      "#{dom_id(message.assistant_thread)}_messages",
      partial: "messages/message",
      locals: {message: message, scroll_to: true},
      target: "#{dom_id(message.assistant_thread)}_messages"
    )
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
end
