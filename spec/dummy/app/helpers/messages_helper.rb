module MessagesHelper
  def message_assistant_options(last_message:)
    options_for_select(
      Assistant.all.map { |option| [option.to_s, option.to_global_id] },
      selected: last_message&.run&.assistant_id
    )
  end
end
