# spec/requests/assistants_request_spec.rb
require "rails_helper"

module AI::Engine
  RSpec.describe AssistantsController, type: :request do
    include Engine.routes.url_helpers

    let(:valid_attributes) do
      build(:assistant).attributes.except("id", "created_at", "updated_at")
    end
    let(:assistant) do
      VCR.use_cassette("requests_assistants_create") do
        expect {
          post assistants_url, params: {assistant: valid_attributes}
        }.to change(Assistant, :count).by(1)
      end
      Assistant.last
    end

    describe "POST /create" do
      context "with valid parameters" do
        it "creates a new Assistant" do
          expect(assistant.name).to eq(valid_attributes["name"])
          # expect(assistant.remote_id).to be_present
        end

        it "redirects to the created assistant" do
          post assistants_url, params: { assistant: valid_attributes }
          expect(response).to redirect_to(assistant_url(Assistant.last))
        end
      end
    end
  end
end
