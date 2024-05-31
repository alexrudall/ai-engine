class CreateAIEngineMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :ai_engine_messages do |t|
      t.string :remote_id, null: false
      t.references :ai_engine_run, null: false, foreign_key: true
      t.references :ai_engine_chat, null: false, foreign_key: true
      t.integer :role, null: false, default: 0
      t.string :content, null: false

      t.timestamps
    end
  end
end
