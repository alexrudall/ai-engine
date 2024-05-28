class UserAssistable < ApplicationRecord
  belongs_to :user
  belongs_to :assistable, polymorphic: true
end
