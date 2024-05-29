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
      # @assistant.remote_id = OpenAI::Assistants::Create.call(
      #   name: assistant_params[:name],
      #   model: assistant_params[:model],
      #   description: assistant_params[:description],
      #   instructions: assistant_params[:instructions]
      # )

      respond_to do |format|
        if @assistant.save
          format.html { redirect_to assistant_url(@assistant), notice: "Assistant was successfully created." }
          format.json { render :show, status: :created, location: @assistant }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @assistant.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /assistants/1 or /assistants/1.json
    def update
      result = Assistant.transaction do
        # OpenAI::Assistants::Update.call(
        #   remote_id: @assistant.remote_id,
        #   name: assistant_params[:name],
        #   model: assistant_params[:model],
        #   description: assistant_params[:description],
        #   instructions: assistant_params[:instructions]
        # )

        @assistant.update(assistant_params)
      end

      respond_to do |format|
        if result
          format.html { redirect_to assistant_url(@assistant), notice: "Assistant was successfully updated." }
          format.json { render :show, status: :ok, location: @assistant }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @assistant.errors, status: :unprocessable_entity }
        end
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

    # Only allow a list of trusted parameters through.
    def assistant_params
      params.require(:assistant).permit(:name, :model, :description, :instructions, :max_prompt_tokens, :max_completion_tokens)
    end
  end
end
