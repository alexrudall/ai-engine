module AI::Engine
  class AssistantsController < ApplicationController
    before_action :set_assistant, only: %i[show edit update destroy]

    # GET /assistants or /assistants.json
    def index
      @assistants = Assistant.all.order(created_at: :desc)
    end

    # GET /assistants/1 or /assistants/1.json
    def show
    end

    # GET /assistants/new
    def new
      @assistant = Assistant.new
    end

    # GET /assistants/1/edit
    def edit
    end

    # POST /assistants or /assistants.json
    def create
      @assistant = Assistant.new(assistant_params)
      create_remote_assistant
      if @assistant.errors.empty? && @assistant.save
        redirect_to @assistant, notice: "Assistant was successfully created."
      else
        render :new, status: :unprocessable_entity, alert: "Failed to create assistant: #{@assistant.errors.full_messages.to_sentence}"
      end
    end

    # PATCH/PUT /assistants/1 or /assistants/1.json
    def update
      if update_remote_assistant && @assistant.update(assistant_params)
        redirect_to @assistant, notice: "Assistant was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /assistants/1 or /assistants/1.json
    def destroy
      @assistant.destroy!

      respond_to do |format|
        format.html { redirect_to assistants_url, notice: "Assistant was successfully deleted." }
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_assistant
      @assistant = Assistant.find(params[:id])
    end

    def create_remote_assistant
      @assistant.remote_id = OpenAI::Assistants::Create.call(
        name: assistant_params[:name],
        model: assistant_params[:model],
        description: assistant_params[:description],
        instructions: assistant_params[:instructions]
      )
    rescue Faraday::Error => e
      @assistant.errors.add(:base, "Failed to create assistant: #{e.response&.dig(:body, "error", "message") || e.message}")
    end

    def update_remote_assistant
      OpenAI::Assistants::Update.call(
        remote_id: @assistant.remote_id,
        name: assistant_params[:name],
        model: assistant_params[:model],
        description: assistant_params[:description],
        instructions: assistant_params[:instructions]
      )
    rescue Faraday::Error => e
      @assistant.errors.add(:base, "Failed to update assistant: #{e.response&.dig(:body, "error", "message") || e.message}")
      false
    end

    # Only allow a list of trusted parameters through.
    def assistant_params
      params.require(:assistant).permit(:name, :model, :description, :instructions, :max_prompt_tokens, :max_completion_tokens)
    end
  end
end
