require "rails_helper"

RSpec.describe AssistantsController, type: :request do
  let(:current_user) { create(:user) }
  let(:valid_attributes) do
    build(:assistant).attributes.except("id", "created_at", "updated_at")
  end
  let(:assistant) do
    VCR.use_cassette("requests_assistants_create") do
      expect {
        post assistants_url, params: {assistant: valid_attributes}
      }.to change(Assistant, :count).by(1)
        .and change(UserAssistable, :count).by(1)
    end
    Assistant.last
  end

  before do
    sign_in current_user
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Assistant and UserAssistable" do
        expect(assistant.name).to eq(valid_attributes["name"])
        expect(assistant.remote_id).to be_present
        expect(UserAssistable.last.user).to eq(current_user)
        expect(UserAssistable.last.assistable).to eq(assistant)

        expect(response).to redirect_to(assistant_url(assistant))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) { {instructions: "Design a big hat"} }

      it "updates the requested assistant, locally AND remotely" do
        VCR.use_cassette("requests_assistants_update") do
          patch assistant_url(assistant), params: {assistant: new_attributes}
        end

        VCR.use_cassette("requests_assistants_retrieve") do
          response = OpenAI::Assistants::Retrieve.call(remote_id: assistant.remote_id)
          expect(response["instructions"]).to eq(new_attributes[:instructions])
        end

        expect(assistant.reload.instructions).to eq(new_attributes[:instructions])
        expect(response).to redirect_to(assistant_url(assistant))
      end
    end
  end
end
