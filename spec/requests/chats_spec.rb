require "rails_helper"

RSpec.describe ChatsController, type: :request do
  let(:current_user) { create(:user) }
  let(:valid_attributes) { {} }

  before do
    sign_in current_user
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Chat" do
        VCR.use_cassette("requests_chats_create") do
          expect {
            post chats_url, params: {chat: valid_attributes}
          }.to change(current_user.chats, :count).by(1)
        end

        expect(AI::Engine::Chat.last.remote_id).to be_present
        expect(response).to redirect_to(chat_url(AI::Engine::Chat.last))
      end
    end
  end
end
