require "rails_helper"

RSpec.describe AssistantsHelper, type: :helper do
  describe "#model_options" do
    it "returns options for the current user's assistants" do
      expect(helper.model_options(assistant: build(:assistant))).to include(AI::Engine::Assistant::MODEL_OPTIONS.sample)
    end
  end
end
