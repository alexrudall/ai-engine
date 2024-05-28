module ChatsHelper
  def chat_assistant_options(chat:)
    options_for_select(
      current_user.assistables.map { |option| [option.to_s, option.to_global_id] },
      selected: chat.assistable&.to_global_id
    )
  end
end
