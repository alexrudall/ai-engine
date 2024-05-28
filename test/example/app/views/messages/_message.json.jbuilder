json.extract! message, :id, :chat_id, :role, :content, :created_at, :updated_at
json.url message_url(message, format: :json)
