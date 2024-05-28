class RenameUserAssistantsToUserAssistables < ActiveRecord::Migration[6.0]
  def change
    rename_table :user_assistants, :user_assistables

    rename_column :user_assistables, :assistant_id, :assistable_id
    add_column :user_assistables, :assistable_type, :string, default: "Assistant"

    add_index :user_assistables, [:assistable_type, :assistable_id]
  end
end
