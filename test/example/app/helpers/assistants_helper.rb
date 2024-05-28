module AssistantsHelper
  MODEL_OPTIONS = %w[
    gpt-3.5-turbo
    gpt-4
    gpt-4-turbo
    gpt-4o
  ].freeze

  def model_options(assistant:)
    options_for_select(MODEL_OPTIONS, selected: assistant.model)
  end
end
