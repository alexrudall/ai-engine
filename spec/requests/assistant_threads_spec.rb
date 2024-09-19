require "rails_helper"

RSpec.describe AssistantThreadsController, type: :request do
  let(:current_user) { create(:user) }
  let(:valid_attributes) { {} }
  let(:assistant_thread) do
    VCR.use_cassette("requests_assistant_threads_create") do
      expect {
        post assistant_threads_url, params: {assistant_thread: valid_attributes}
      }.to change(current_user.assistant_threads, :count).by(1)
    end
    current_user.assistant_threads.last
  end

  before do
    sign_in current_user
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new AssistantThread" do
        assistant_thread
        expect(AI::Engine::AssistantThread.last.remote_id).to be_present
        expect(response).to redirect_to(assistant_thread_url(AI::Engine::AssistantThread.last))
      end
    end
  end

  describe "DELETE /destroy" do
    it "deletes the requested AssistantThread and calls the remote delete method" do
      assistant_thread # Ensure the thread is created before attempting to delete it
      remote_id = assistant_thread.remote_id

      VCR.use_cassette("requests_assistant_threads_destroy") do
        allow(AI::Engine::OpenAI::Threads::Delete).to receive(:call).and_call_original

        expect {
          delete assistant_thread_url(assistant_thread)
        }.to change(AI::Engine::AssistantThread, :count).by(-1)

        expect { assistant_thread.reload }.to raise_error(ActiveRecord::RecordNotFound)
        expect(AI::Engine::OpenAI::Threads::Delete).to have_received(:call).with(remote_id: remote_id)
      end

      expect(response).to redirect_to(assistant_threads_url)
    end
  end
end
