class CreateAIEngineChats < ActiveRecord::Migration[7.1]
  def change
    create_table :ai_engine_chats do |t|
      t.string :remote_id
      t.belongs_to :chattable, polymorphic: true

      t.timestamps
    end
  end
end
