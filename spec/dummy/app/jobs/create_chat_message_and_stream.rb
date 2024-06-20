class CreateChatMessageAndStream < SidekiqJob
  def perform(args)
    chat_id, user_id, content = args.values_at("chat_id", "user_id", "content")

    user = User.find(user_id)

    chat = user.chats.find(chat_id)

    chat.messages.create(content: content, role: "user")

    chat.run
  end
end
