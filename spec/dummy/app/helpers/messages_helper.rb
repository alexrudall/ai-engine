module MessagesHelper
  def message_storyteller_options(chat:, selected_storyteller_id: nil)
    options_for_select(
      chat.chattable.storytellers.map { |storyteller| [storyteller.name, storyteller.id] },
      selected: selected_storyteller_id || chat.messages.order(:created_at).last&.run&.assistant&.assistable_id
    )
  end
end
