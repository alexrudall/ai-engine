module PipelinesHelper
  def pipeline_assistant_options(pipeline_assistant:)
    options_for_select(current_user.assistants.map { |assistant| [assistant.name, assistant.id] }, selected: pipeline_assistant.assistant_id)
  end
end
