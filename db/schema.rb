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

ActiveRecord::Schema.define(:version => 20111206182545) do

  create_table "checker_data", :force => true do |t|
    t.integer  "checker_id"
    t.text     "input"
    t.text     "output"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "checkers", :force => true do |t|
    t.integer  "problem_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "competitions", :force => true do |t|
    t.integer  "organizer_id"
    t.string   "name"
    t.text     "description"
    t.datetime "deadline"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "guardian_memberships", :force => true do |t|
    t.integer  "guardian_id"
    t.integer  "problem_membership_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.string   "token"
    t.boolean  "confirmed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "judge_memberships", :force => true do |t|
    t.integer  "judge_id"
    t.integer  "competition_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "problem_memberships", :force => true do |t|
    t.integer  "problem_id"
    t.integer  "competition_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "points"
    t.datetime "start_time"
    t.datetime "end_time"
  end

  create_table "problems", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "points"
    t.text     "description"
    t.integer  "author_id"
  end

  create_table "solutions", :force => true do |t|
    t.integer  "team_membership_id"
    t.integer  "problem_membership_id"
    t.string   "code_file_name"
    t.string   "code_content_type"
    t.integer  "code_file_size"
    t.datetime "code_updated_at"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "score",                 :default => 0.0
  end

  create_table "team_memberships", :force => true do |t|
    t.integer  "team_id"
    t.integer  "competition_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", :force => true do |t|
    t.integer  "leader_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_team_memberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                                 :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
