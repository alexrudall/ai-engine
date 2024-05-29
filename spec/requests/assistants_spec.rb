# spec/requests/assistants_request_spec.rb
require "rails_helper"

module AI::Engine
  RSpec.describe AssistantsController, type: :request do
    include Engine.routes.url_helpers

    let(:valid_attributes) {
      {name: "Test Assistant"}
    }

    describe "POST /create" do
      context "with valid parameters" do
        it "creates a new Assistant" do
          expect {
            post assistants_url, params: { assistant: valid_attributes }
          }.to change(AI::Engine::Assistant, :count).by(1)
        end

        it "redirects to the created assistant" do
          post assistants_url, params: { assistant: valid_attributes }
          expect(response).to redirect_to(assistant_url(Assistant.last))
        end
      end
    end
  end
end
