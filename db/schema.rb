# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120922212149) do

  create_table "conversations", :force => true do |t|
    t.integer  "message_id"
    t.integer  "user_id"
    t.string   "from_phone"
    t.string   "from_email"
    t.boolean  "incoming"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "conversations", ["from_email"], :name => "index_conversations_on_from_email"
  add_index "conversations", ["from_phone"], :name => "index_conversations_on_from_phone"
  add_index "conversations", ["message_id"], :name => "index_conversations_on_message_id"

  create_table "messages", :force => true do |t|
    t.integer  "conversation_id"
    t.string   "phone"
    t.string   "email"
    t.string   "content"
    t.boolean  "incoming"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "messages", ["conversation_id"], :name => "index_messages_on_conversation_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "conversation_id"
    t.string   "phone"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["phone"], :name => "index_users_on_phone", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
