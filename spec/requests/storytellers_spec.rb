require "rails_helper"

RSpec.describe StorytellersController, type: :request do
  let(:current_user) { create(:user) }
  let(:valid_attributes) do
    build(:storyteller).attributes.except("id", "created_at", "updated_at", "remote_id")
  end
  before do
    sign_in current_user
  end

  describe "POST /create" do
    context "with valid parameters" do
      let(:storyteller) do
        VCR.use_cassette("requests_storytellers_create") do
          expect {
            post storytellers_url, params: {storyteller: valid_attributes}
          }.to change(Storyteller, :count).by(1)
        end
        Storyteller.last
      end

      it "creates a new Storyteller" do
        expect(storyteller.name).to eq(valid_attributes["name"])
        expect(storyteller.user).to eq(current_user)
        expect(storyteller.assistant.remote_id).to be_present

        expect(response).to redirect_to(storyteller_url(storyteller))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:storyteller) do
        VCR.use_cassette("requests_storytellers_update_create") do
          expect {
            post storytellers_url, params: {storyteller: valid_attributes}
          }.to change(Storyteller, :count).by(1)
        end
        Storyteller.last
      end
      let(:new_attributes) { {instructions: "Design a big hat"} }

      it "updates the requested storyteller, locally AND remotely" do
        VCR.use_cassette("requests_storytellers_update") do
          patch storyteller_url(storyteller), params: {storyteller: new_attributes}
        end

        VCR.use_cassette("requests_storytellers_retrieve") do
          response = AI::Engine::OpenAI::Assistants::Retrieve.call(remote_id: storyteller.assistant.remote_id)
          expect(response["instructions"]).to eq(new_attributes[:instructions])
        end

        expect(storyteller.reload.instructions).to eq(new_attributes[:instructions])
        expect(response).to redirect_to(storyteller_url(storyteller))
      end
    end
  end

  describe "DELETE /destroy" do
    context "with a remote Assistant" do
      let(:storyteller) do
        VCR.use_cassette("requests_storytellers_delete_create") do
          expect {
            post storytellers_url, params: {storyteller: valid_attributes}
          }.to change(Storyteller, :count).by(1)
        end
        Storyteller.last
      end

      it "deletes the requested storyteller and calls the remote delete method" do
        storyteller # Ensure the storyteller is created before attempting to delete it
        assistant = storyteller.assistant
        remote_id = storyteller.assistant.remote_id

        VCR.use_cassette("requests_storytellers_destroy") do
          allow(AI::Engine::OpenAI::Assistants::Delete).to receive(:call).and_call_original

          expect {
            delete storyteller_url(storyteller)
          }.to change(Storyteller, :count).by(-1)

          expect { assistant.reload }.to raise_error(ActiveRecord::RecordNotFound)
          expect(AI::Engine::OpenAI::Assistants::Delete).to have_received(:call).with(remote_id: remote_id)
        end

        expect(response).to redirect_to(storytellers_url)
      end
    end

    context "when the remote Assistant has already been deleted" do
      let(:storyteller) do
        VCR.use_cassette("requests_storytellers_double_delete_create") do
          expect {
            post storytellers_url, params: {storyteller: valid_attributes}
          }.to change(Storyteller, :count).by(1)
        end
        Storyteller.last
      end

      it "deletes the requested storyteller and calls the remote delete method" do
        storyteller # Ensure the storyteller is created before attempting to delete it
        assistant = storyteller.assistant
        remote_id = storyteller.assistant.remote_id

        # For the test, the remote assistant is already deleted:
        VCR.use_cassette("requests_storytellers_predestroy") do
          AI::Engine::OpenAI::Assistants::Delete.call(remote_id: remote_id)
        end

        VCR.use_cassette("requests_storytellers_double_destroy") do
          allow(AI::Engine::OpenAI::Assistants::Delete).to receive(:call).and_call_original

          expect {
            delete storyteller_url(storyteller)
          }.to change(Storyteller, :count).by(-1)

          expect { assistant.reload }.to raise_error(ActiveRecord::RecordNotFound)
          expect(AI::Engine::OpenAI::Assistants::Delete).to have_received(:call).with(remote_id: remote_id)
        end

        expect(response).to redirect_to(storytellers_url)
      end
    end
  end
end
