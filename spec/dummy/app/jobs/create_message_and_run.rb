class CreateMessageAndRun < SidekiqJob
  def perform(args)
    storyteller_id, chat_id, user_id, content = args.values_at("storyteller_id", "chat_id", "user_id", "content")

    user = User.find(user_id)
    chat = user.chats.find(chat_id)

    storyteller = user.storytellers.find(storyteller_id)
    assistant = storyteller.assistant

    chat.run(assistant_id: assistant.id, content: content)
  end
end
