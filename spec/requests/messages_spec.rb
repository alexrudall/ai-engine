require "rails_helper"

RSpec.describe MessagesController, type: :request do
  let(:current_user) { create(:user) }

  before do
    sign_in current_user
  end

  describe "POST /create" do
    context "with valid parameters" do
      context "with a chat" do
        let(:chat) { current_user.chats.create }
        let(:model) { AI::Engine::MODEL_OPTIONS.sample }
        let(:valid_attributes) { {chat_id: chat.id, content: "Hi there", model: model} }

        it "creates a new Message" do
          # Sends the message history off to OpenAI and gets the response.
          VCR.use_cassette("requests_chat_messages_create_and_run") do
            expect {
              post messages_url, as: :turbo_stream, params: {message: valid_attributes}
            }.to change(chat.messages, :count).by(2)
          end

          expect(chat.messages.count).to eq(2)
          response = chat.messages.last
          expect(response.content).to be_present
          expect(response.model).to eq(model)
          expect(response.remote_id).to eq(nil)
        end
      end

      context "with an assistant" do
        let(:storyteller) do
          current_user.storytellers << build(:storyteller)
          current_user.storytellers.last
        end
        let(:assistant_thread) { current_user.assistant_threads.create }
        let(:valid_attributes) { {assistant_thread_id: assistant_thread.id, storyteller_id: storyteller.id, content: "Hi there"} }

        it "creates a new Message" do
          # Creates an assistant, thread, run and request and response messages on the OpenAI API.
          VCR.use_cassette("requests_assistant_messages_create_and_run") do
            expect {
              post messages_url, as: :turbo_stream, params: {message: valid_attributes}
            }.to change(assistant_thread.messages, :count).by(2)
          end

          expect(assistant_thread.messages.count).to eq(2)
          response = assistant_thread.messages.last
          expect(response.remote_id).to be_present
          expect(response.run).to be_present
          expect(response.model).to eq(storyteller.model)
          expect(response.prompt_token_usage).to be_present
          expect(response.completion_token_usage).to be_present
        end
      end
    end
  end

  describe "Deleting the AssistantThread" do
    let(:storyteller) do
      current_user.storytellers << build(:storyteller)
      current_user.storytellers.last
    end
    let(:assistant_thread) { current_user.assistant_threads.create }
    let(:valid_attributes) { {assistant_thread_id: assistant_thread.id, storyteller_id: storyteller.id, content: "Hi there"} }

    before do
      # Creates an assistant, thread, run and request and response messages on the OpenAI API.
      VCR.use_cassette("requests_assistant_messages_create_and_run") do
        expect {
          post messages_url, as: :turbo_stream, params: {message: valid_attributes}
        }.to change(assistant_thread.messages, :count).by(2)
      end
    end

    it "deletes the requested AssistantThread, Run and Messages and calls the remote delete method for the Thread (remote Run will remain, remote Message should be deleted by the Thread)" do
      assistant = storyteller.assistant
      run = assistant.runs.first
      request_message = assistant_thread.messages.user.first
      response_message = assistant_thread.messages.assistant.first

      VCR.use_cassette("requests_assistant_thread_run_message_destroy") do
        allow(AI::Engine::OpenAI::Threads::Delete).to receive(:call).and_call_original

        expect {
          delete assistant_thread_url(assistant_thread)
        }.to change(AI::Engine::AssistantThread, :count).by(-1)

        expect { assistant_thread.reload }.to raise_error(ActiveRecord::RecordNotFound)
        expect { run.reload }.to raise_error(ActiveRecord::RecordNotFound)
        expect { request_message.reload }.to raise_error(ActiveRecord::RecordNotFound)
        expect { response_message.reload }.to raise_error(ActiveRecord::RecordNotFound)

        expect(AI::Engine::OpenAI::Threads::Delete).to have_received(:call).with(remote_id: assistant_thread.remote_id)
      end
    end
  end

  describe "Deleting the Chat" do
    let(:chat) { current_user.chats.create }
    let(:model) { AI::Engine::MODEL_OPTIONS.sample }
    let(:valid_attributes) { {chat_id: chat.id, content: "Hi there", model: model} }

    before do
      # Sends the message history off to OpenAI and gets the response.
      VCR.use_cassette("requests_chat_messages_create_and_run") do
        expect {
          post messages_url, as: :turbo_stream, params: {message: valid_attributes}
        }.to change(chat.messages, :count).by(2)
      end
    end

    it "deletes the requested Chat and Messages" do
      request_message = chat.messages.user.first
      response_message = chat.messages.assistant.first

      VCR.use_cassette("requests_chat_message_destroy") do
        expect {
          delete chat_url(chat)
        }.to change(AI::Engine::Chat, :count).by(-1)

        expect { chat.reload }.to raise_error(ActiveRecord::RecordNotFound)
        expect { request_message.reload }.to raise_error(ActiveRecord::RecordNotFound)
        expect { response_message.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
