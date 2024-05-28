class PipelineAssistant < ApplicationRecord
  include RankedModel
  ranks :row_order, with_same: :pipeline_id

  belongs_to :pipeline
  belongs_to :assistant
end
