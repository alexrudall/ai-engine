module MessagesHelper
  def message_storyteller_options(chat:)
    options_for_select(
      chat.chattable.storytellers.map { |storyteller| [storyteller.name, storyteller.id] },
      selected: chat.messages.last&.run&.assistant&.assistable_id
    )
  end
end
