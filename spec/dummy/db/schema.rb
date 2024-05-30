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

ActiveRecord::Schema[7.1].define(version: 2024_05_28_153439) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "ai_engine_assistants", force: :cascade do |t|
    t.string "remote_id"
    t.string "name", null: false
    t.string "model"
    t.string "description"
    t.string "instructions"
    t.integer "max_prompt_tokens"
    t.integer "max_completion_tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["remote_id"], name: "index_ai_engine_assistants_on_remote_id", unique: true
  end

  create_table "assistants", force: :cascade do |t|
    t.string "remote_id", null: false
    t.string "name", null: false
    t.string "model", null: false
    t.string "description", null: false
    t.string "instructions", null: false
    t.integer "max_prompt_tokens", default: 256, null: false
    t.integer "max_completion_tokens", default: 16, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["remote_id"], name: "index_assistants_on_remote_id", unique: true
  end

  create_table "chats", force: :cascade do |t|
    t.string "remote_id"
    t.bigint "assistable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "assistable_type", default: "Assistant"
    t.index ["assistable_id"], name: "index_chats_on_assistable_id"
    t.index ["assistable_type", "assistable_id"], name: "index_chats_on_assistable_type_and_assistable_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "remote_id"
    t.bigint "chat_id", null: false
    t.bigint "user_id", null: false
    t.integer "role", default: 0, null: false
    t.string "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "assistant_id"
    t.index ["assistant_id"], name: "index_messages_on_assistant_id"
    t.index ["chat_id"], name: "index_messages_on_chat_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "pipeline_assistants", force: :cascade do |t|
    t.bigint "pipeline_id", null: false
    t.bigint "assistant_id", null: false
    t.integer "row_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assistant_id"], name: "index_pipeline_assistants_on_assistant_id"
    t.index ["pipeline_id"], name: "index_pipeline_assistants_on_pipeline_id"
  end

  create_table "pipelines", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_assistables", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "assistable_id", null: false
    t.string "assistable_type", default: "Assistant", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assistable_id"], name: "index_user_assistables_on_assistable_id"
    t.index ["assistable_type", "assistable_id"], name: "index_user_assistables_on_assistable_type_and_assistable_id"
    t.index ["user_id"], name: "index_user_assistables_on_user_id"
  end

  create_table "user_chats", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "chat_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_user_chats_on_chat_id"
    t.index ["user_id"], name: "index_user_chats_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name"
    t.string "remote_id"
    t.string "avatar_url"
    t.string "provider"
    t.citext "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "messages", "chats"
  add_foreign_key "messages", "users"
  add_foreign_key "pipeline_assistants", "assistants"
  add_foreign_key "pipeline_assistants", "pipelines"
  add_foreign_key "user_assistables", "users"
  add_foreign_key "user_chats", "chats"
  add_foreign_key "user_chats", "users"
end
