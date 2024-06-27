require "rails_helper"

RSpec.describe StorytellersHelper, type: :helper do
  describe "#model_options" do
    it "returns options for the current user's storytellers" do
      expect(helper.model_options(storyteller: build(:storyteller))).to include(AI::Engine::MODEL_OPTIONS.sample)
    end
  end
end
