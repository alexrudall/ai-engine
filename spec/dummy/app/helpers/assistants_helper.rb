module AssistantsHelper
  def model_options(assistant:)
    options_for_select(AI::Engine::Assistant::MODEL_OPTIONS, selected: assistant.model)
  end
end
