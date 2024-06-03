require "rails_helper"

RSpec.describe MessagesController, type: :request do
  let(:current_user) { create(:user) }
  let(:storyteller) do
    current_user.storytellers << build(:storyteller)
    current_user.storytellers.last
  end
  let(:valid_attributes) { {storyteller_id: storyteller.id, content: "Hi there"} }

  before do
    sign_in current_user
  end

  describe "POST /create" do
    context "with valid parameters" do
      context "with an assistant" do
        it "creates a new Message" do
          # Creates a chat, assistant, thread and request and response messages on the OpenAI API.
          VCR.use_cassette("requests_messages_create_and_run") do
            chat = current_user.chats.create

            expect {
              post chat_messages_url(chat_id: chat.id), as: :turbo_stream, params: {message: valid_attributes}
            }.to change(current_user.chats.last.messages, :count).by(2)
          end

          chat = current_user.chats.last
          expect(chat.messages.count).to eq(2)
        end
      end
    end
  end
end