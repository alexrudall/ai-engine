class AddPipelineAssistants < ActiveRecord::Migration[7.1]
  def change
    create_table :pipeline_assistants do |t|
      t.references :pipeline, null: false, foreign_key: true
      t.references :assistant, null: false, foreign_key: true
      t.integer :row_order

      t.timestamps
    end
  end
end
