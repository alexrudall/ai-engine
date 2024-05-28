class Pipeline < ApplicationRecord
  include Nameable

  has_many :user_assistables, as: :assistable, dependent: :destroy
  has_many :users, through: :user_assistables
  has_many :pipeline_assistants, dependent: :destroy
  has_many :chats, as: :assistable, dependent: :destroy
  has_many :assistants, through: :pipeline_assistants, dependent: :destroy
  accepts_nested_attributes_for :pipeline_assistants, allow_destroy: true, reject_if: :all_blank

  validates :name, presence: true
end
