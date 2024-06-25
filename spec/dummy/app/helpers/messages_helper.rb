module MessagesHelper
  def message_model_options(selected_model: nil)
    options_for_select(
      AI::Engine::Chat::MODEL_OPTIONS,
      selected: selected_model
    )
  end

  def message_storyteller_options(assistant_thread:, selected_storyteller_id: nil)
    options_for_select(
      assistant_thread.threadable.storytellers.map { |storyteller| [storyteller.name, storyteller.id] },
      selected: selected_storyteller_id || assistant_thread.messages.order(:created_at).last&.run&.assistant&.assistable_id
    )
  end
end
