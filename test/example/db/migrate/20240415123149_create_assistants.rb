class CreateAssistants < ActiveRecord::Migration[7.1]
  def change
    create_table :assistants do |t|
      t.string :remote_id, null: false
      t.string :name, null: false
      t.string :model, null: false
      t.string :description, null: false
      t.string :instructions, null: false
      t.integer :max_prompt_tokens, null: false, default: Assistant::MIN_PROMPT_TOKENS
      t.integer :max_completion_tokens, null: false, default: Assistant::MIN_COMPLETION_TOKENS

      t.timestamps
    end

    add_index :assistants, :remote_id, unique: true
  end
end
