class Chat < ApplicationRecord
  belongs_to :assistable, polymorphic: true
  has_many :user_chats, dependent: :destroy
  has_many :users, through: :user_chats, source: :user
  has_many :messages, -> { order(created_at: :asc) }, dependent: :destroy
end
