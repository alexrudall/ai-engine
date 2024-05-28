require "rails_helper"

RSpec.describe ChatsController, type: :request do
  let(:current_user) { create(:user) }
  let(:assistant) do
    VCR.use_cassette("requests_assistants_create") do
      post assistants_url, params: {assistant: build(:assistant).attributes}
      Assistant.last
    end
  end
  let(:pipeline) { create(:pipeline, users: [current_user], assistants: [assistant]) }
  let(:valid_attributes) { {assistable_id: pipeline.to_global_id} }

  before do
    sign_in current_user
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Chat" do
        VCR.use_cassette("requests_chats_create") do
          expect {
            post chats_url, params: {chat: valid_attributes}
          }.to change(Chat, :count).by(1)
            .and change(UserChat, :count).by(1)
        end

        expect(UserChat.last.user).to eq(current_user)
        expect(UserChat.last.chat).to eq(Chat.last)
        expect(Chat.last.assistable).to eq(pipeline)
        expect(Chat.last.remote_id).to be_present
        expect(response).to redirect_to(chat_url(Chat.last))
      end
    end
  end
end
