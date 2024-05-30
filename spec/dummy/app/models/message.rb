class Message < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :chat
  belongs_to :user
  belongs_to :assistant, optional: true

  enum role: {system: 0, assistant: 10, user: 20}

  after_update_commit -> { broadcast_updated }

  def broadcast_created
    broadcast_append_later_to(
      "#{dom_id(chat)}_messages",
      partial: "messages/message",
      locals: {message: self, scroll_to: true},
      target: "#{dom_id(chat)}_messages"
    )
  end

  def broadcast_updated
    broadcast_append_to(
      "#{dom_id(chat)}_messages",
      partial: "messages/message",
      locals: {message: self, scroll_to: true},
      target: "#{dom_id(chat)}_messages"
    )
  end
end
