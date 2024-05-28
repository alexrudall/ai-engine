class CreateUserAssistants < ActiveRecord::Migration[7.1]
  def change
    create_table :user_assistants do |t|
      t.references :user, null: false, foreign_key: true
      t.references :assistant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
