json.extract! chat, :id, :remote_id, :assistant_id, :created_at, :updated_at
json.url chat_url(chat, format: :json)
