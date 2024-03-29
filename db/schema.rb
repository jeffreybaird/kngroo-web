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

ActiveRecord::Schema.define(:version => 20111113015141) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer   "resource_id",   :null => false
    t.string    "resource_type", :null => false
    t.integer   "author_id"
    t.string    "author_type"
    t.text      "body"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string    "email",                                 :default => "", :null => false
    t.string    "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string    "reset_password_token"
    t.timestamp "reset_password_sent_at"
    t.timestamp "remember_created_at"
    t.integer   "sign_in_count",                         :default => 0
    t.timestamp "current_sign_in_at"
    t.timestamp "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "assignments", :force => true do |t|
    t.integer   "user_id"
    t.integer   "hop_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.boolean   "complete"
  end

  create_table "attempts", :force => true do |t|
    t.integer   "trivia_id"
    t.integer   "user_id"
    t.boolean   "correct_answer", :default => false
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string    "title"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "icon"
  end

  create_table "checkins", :force => true do |t|
    t.integer   "venue_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "assignment_id"
  end

  create_table "confirmations", :force => true do |t|
    t.integer   "trivia_id"
    t.integer   "user_id"
    t.boolean   "correct_answer"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "hops", :force => true do |t|
    t.string    "title"
    t.text      "description"
    t.integer   "category_id"
    t.integer   "points"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.boolean   "featured"
    t.timestamp "published_at"
    t.string    "stamp_name"
    t.string    "stamp_file_name"
    t.string    "stamp_content_type"
    t.integer   "stamp_file_size"
    t.datetime  "stamp_updated_at"
    t.string    "image_file_name"
    t.string    "image_content_type"
    t.integer   "image_file_size"
    t.datetime  "image_updated_at"
  end

  create_table "memberships", :force => true do |t|
    t.integer   "hop_id"
    t.integer   "venue_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "trivia", :force => true do |t|
    t.integer   "hop_id"
    t.integer   "venue_id"
    t.text      "question"
    t.string    "answer"
    t.boolean   "numeric_answer"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "trophies", :force => true do |t|
    t.integer   "hop_id"
    t.integer   "user_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string    "email"
    t.string    "encrypted_password", :limit => 128
    t.string    "salt",               :limit => 128
    t.string    "confirmation_token", :limit => 128
    t.string    "remember_token",     :limit => 128
    t.string    "api_token",          :limit => 128
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "points"
    t.string    "role_name"
    t.string    "first_name"
    t.string    "last_name"
  end

  add_index "users", ["api_token"], :name => "index_users_on_api_token"
  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

  create_table "venues", :force => true do |t|
    t.string    "name"
    t.text      "description"
    t.float     "lat"
    t.float     "lng"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "address"
  end

end
