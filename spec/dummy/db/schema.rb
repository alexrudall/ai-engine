# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 0) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ai_engine_assistants", force: :cascade do |t|
    t.string "remote_id", null: false
    t.string "assistable_type"
    t.bigint "assistable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assistable_type", "assistable_id", "remote_id"], name: "idx_on_assistable_type_assistable_id_remote_id_bea46cd0e4", unique: true
    t.index ["assistable_type", "assistable_id"], name: "index_ai_engine_assistants_on_assistable"
  end

  create_table "ai_engine_chats", force: :cascade do |t|
    t.string "remote_id", null: false
    t.string "chattable_type"
    t.bigint "chattable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chattable_type", "chattable_id"], name: "index_ai_engine_chats_on_chattable"
  end

  create_table "ai_engine_runs", force: :cascade do |t|
    t.string "remote_id", null: false
    t.bigint "ai_engine_assistant_id"
    t.bigint "ai_engine_chat_id"
    t.integer "prompt_token_usage"
    t.integer "completion_token_usage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ai_engine_assistant_id"], name: "index_ai_engine_runs_on_ai_engine_assistant_id"
    t.index ["ai_engine_chat_id"], name: "index_ai_engine_runs_on_ai_engine_chat_id"
  end

  add_foreign_key "ai_engine_runs", "ai_engine_assistants"
  add_foreign_key "ai_engine_runs", "ai_engine_chats"
end
