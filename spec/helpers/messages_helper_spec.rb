require "rails_helper"

RSpec.describe MessagesHelper, type: :helper do
  describe "#message_assistant_options" do
    let(:current_user) { create(:user) }
    let(:other_user) { create(:user) }
    let!(:storyteller1) { create(:storyteller, user: current_user) }
    let!(:storyteller2) { create(:storyteller, user: other_user) }

    before do
      allow(controller).to receive(:current_user).and_return(current_user)
    end

    it "returns options for the current user's storytellers" do
      expect(helper.message_storyteller_options(user: current_user, last_message: nil)).to include(storyteller1.name)
      expect(helper.message_storyteller_options(user: current_user, last_message: nil)).not_to include(storyteller2.name)
    end
  end
end
