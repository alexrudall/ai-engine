class CreateUserAssistables < ActiveRecord::Migration[7.1]
  def change
    create_table :user_assistables do |t|
      t.references :user, null: false, foreign_key: true
      t.references :assistable, null: false
      t.string :assistable_type, null: false, default: "Assistant"

      t.timestamps
    end

    add_index :user_assistables, [:assistable_type, :assistable_id]
  end
end
