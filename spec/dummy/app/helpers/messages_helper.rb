module MessagesHelper
  def message_storyteller_options(user:, last_message:)
    options_for_select(
      user.storytellers.map { |storyteller| [storyteller.name, storyteller.id] },
      selected: last_message&.run&.assistant&.assistable_id
    )
  end
end
