require "rails_helper"

RSpec.describe MessagesController, type: :request do
  let(:current_user) { create(:user) }
  let(:assistant) do
    VCR.use_cassette("requests_assistants_create") do
      post assistants_url, params: {assistant: build(:assistant).attributes}
      Assistant.last
    end
  end
  let(:chat_id) do
    VCR.use_cassette("requests_chats_create") do
      post chats_url, params: {chat: {assistable_id: assistable.to_global_id}}
      Chat.last.id
    end
  end
  let(:valid_attributes) { {content: "Hi there"} }

  before do
    sign_in current_user
  end

  describe "POST /create" do
    context "with valid parameters" do
      context "with an assistant" do
        let(:assistable) { assistant }

        it "creates a new Message" do
          VCR.use_cassette("requests_messages_assistant_create") do
            expect {
              post chat_messages_url(chat_id: chat_id), as: :turbo_stream, params: {message: valid_attributes}
            }.to change(Message, :count).by(2)
          end

          expect(Chat.last.messages.count).to eq(2)
          expect(Message.first.user_id).to eq(current_user.id)
          expect(Message.last.user).to eq(User.system)
          expect(Message.last.assistant).to eq(assistant)
        end
      end
    end
  end
end
