class CreateAIEngineAssistants < ActiveRecord::Migration[7.1]
  def change
    create_table :ai_engine_assistants do |t|
      t.string :remote_id
      t.string :name, null: false
      t.string :model
      t.string :description
      t.string :instructions
      t.integer :max_prompt_tokens
      t.integer :max_completion_tokens

      t.timestamps
    end

    add_index :ai_engine_assistants, :remote_id, unique: true
  end
end
