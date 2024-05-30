class RefactorChatAssistantToAssistable < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :chats, :assistants
    rename_column :chats, :assistant_id, :assistable_id
    add_column :chats, :assistable_type, :string, default: "Assistant"

    add_index :chats, [:assistable_type, :assistable_id]
  end
end
