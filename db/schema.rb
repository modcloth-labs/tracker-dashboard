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

ActiveRecord::Schema.define(:version => 20130112044519) do

  create_table "credentials", :force => true do |t|
    t.string   "token"
    t.string   "auth_user"
    t.string   "auth_password"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "iterations", :force => true do |t|
    t.integer  "project_id"
    t.integer  "number"
    t.datetime "start"
    t.datetime "finish"
    t.string   "kind"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "iterations", ["project_id", "kind"], :name => "index_iterations_on_project_id_and_kind"

  create_table "labelings", :force => true do |t|
    t.integer  "story_id"
    t.integer  "project_id"
    t.integer  "label_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "labelings", ["label_id"], :name => "index_labelings_on_label_id"
  add_index "labelings", ["project_id"], :name => "index_labelings_on_project_id"
  add_index "labelings", ["story_id"], :name => "index_labelings_on_story_id"

  create_table "labels", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "labels", ["name"], :name => "index_labels_on_name"

  create_table "parameters", :force => true do |t|
    t.string   "name"
    t.text     "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "projects", :force => true do |t|
    t.integer  "tracker_id"
    t.integer  "credentials_id"
    t.string   "name"
    t.text     "all_labels",     :default => "", :null => false
    t.text     "enabled_labels", :default => "", :null => false
    t.boolean  "enabled"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "stories", :force => true do |t|
    t.integer  "project_id"
    t.integer  "iteration_id"
    t.integer  "estimate"
    t.string   "name"
    t.string   "tracker_id"
    t.string   "url"
    t.string   "current_state"
    t.string   "story_type"
    t.string   "requested_by"
    t.string   "owned_by"
    t.string   "tracker_labels"
    t.datetime "tracker_created_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "stories", ["iteration_id"], :name => "index_stories_on_iteration_id"
  add_index "stories", ["project_id"], :name => "index_stories_on_project_id"

end
