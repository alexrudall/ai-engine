class AddAssistantIdToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :assistant_id, :bigint
    add_index :messages, :assistant_id
  end
end
