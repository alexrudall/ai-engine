require "rails_helper"

RSpec.describe MessagesHelper, type: :helper do
  describe "#message_assistant_options" do
    let(:current_user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:storyteller1) { create(:storyteller, user: current_user) }
    let(:storyteller2) { create(:storyteller, user: other_user) }
    let(:assistant_thread) { create(:assistant_thread, threadable: current_user) }
    let(:assistants_service) { class_double(AI::Engine::OpenAI::Assistants::Create).as_stubbed_const }
    let(:threads_service) { class_double(AI::Engine::OpenAI::Threads::Create).as_stubbed_const }

    before do
      allow(assistants_service).to receive(:call).and_return(build(:assistant).remote_id)
      allow(threads_service).to receive(:call).and_return(build(:assistant_thread).remote_id)
      allow(controller).to receive(:current_user).and_return(current_user)
      storyteller1
      storyteller2
    end

    it "returns options for the current user's storytellers" do
      expect(helper.message_storyteller_options(assistant_thread: assistant_thread)).to include(storyteller1.name)
      expect(helper.message_storyteller_options(assistant_thread: assistant_thread)).not_to include(storyteller2.name)
    end
  end
end
