require "rails_helper"

RSpec.describe MessagesHelper, type: :helper do
  describe "#message_assistant_options" do
    let(:current_user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:storyteller1) { create(:storyteller, user: current_user) }
    let(:storyteller2) { create(:storyteller, user: other_user) }
    let(:chat) { create(:chat, chattable: current_user) }
    let(:assistants_service) { class_double(AI::Engine::OpenAI::Assistants::Create).as_stubbed_const }
    let(:threads_service) { class_double(AI::Engine::OpenAI::Threads::Create).as_stubbed_const }

    before do
      allow(assistants_service).to receive(:call).and_return(Faker::Alphanumeric.alphanumeric(number: 10))
      allow(threads_service).to receive(:call).and_return(Faker::Alphanumeric.alphanumeric(number: 10))
      allow(controller).to receive(:current_user).and_return(current_user)
      storyteller1
      storyteller2
    end

    it "returns options for the current user's storytellers" do
      expect(helper.message_storyteller_options(chat: chat)).to include(storyteller1.name)
      expect(helper.message_storyteller_options(chat: chat)).not_to include(storyteller2.name)
    end
  end
end
