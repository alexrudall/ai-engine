require "rails_helper"

RSpec.describe ChatsHelper, type: :helper do
  describe "#chat_assistant_options" do
    let(:current_user) { create(:user) }
    let(:other_user) { create(:user) }
    let!(:assistant1) { create(:assistant, users: [current_user]) }
    let!(:assistant2) { create(:assistant, users: [other_user]) }

    before do
      allow(controller).to receive(:current_user).and_return(current_user)
    end

    it "returns options for the current user's assistants" do
      expect(helper.chat_assistant_options(chat: build(:chat))).to include(assistant1.name)
      expect(helper.chat_assistant_options(chat: build(:chat))).not_to include(assistant2.name)
    end
  end
end
