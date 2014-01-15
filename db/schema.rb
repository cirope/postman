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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140115002509) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true, using: :btree

  create_table "feedbacks", force: true do |t|
    t.string   "from",       null: false
    t.string   "score",      null: false
    t.text     "notes"
    t.integer  "ticket_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feedbacks", ["ticket_id"], name: "index_feedbacks_on_ticket_id", using: :btree

  create_table "messages", force: true do |t|
    t.text     "body",       null: false
    t.datetime "sent_at"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "replies", force: true do |t|
    t.text     "body"
    t.integer  "ticket_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "replies", ["ticket_id"], name: "index_replies_on_ticket_id", using: :btree

  create_table "tenants", force: true do |t|
    t.string   "name",       null: false
    t.string   "email",      null: false
    t.string   "subdomain",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tenants", ["email"], name: "index_tenants_on_email", unique: true, using: :btree
  add_index "tenants", ["subdomain"], name: "index_tenants_on_subdomain", unique: true, using: :btree

  create_table "tickets", force: true do |t|
    t.string   "from",                               null: false, array: true
    t.string   "subject",                            null: false
    t.string   "status",                             null: false
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tenant_id",                          null: false
    t.integer  "category_id"
    t.boolean  "feedback_requested", default: false, null: false
    t.integer  "user_id"
  end

  add_index "tickets", ["category_id"], name: "index_tickets_on_category_id", using: :btree
  add_index "tickets", ["tenant_id"], name: "index_tickets_on_tenant_id", using: :btree
  add_index "tickets", ["user_id"], name: "index_tickets_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name",                               null: false
    t.string   "lastname",                           null: false
    t.string   "email",                              null: false
    t.string   "password_digest",                    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "auth_token",                         null: false
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.integer  "lock_version",           default: 0, null: false
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["password_reset_token"], name: "index_users_on_password_reset_token", unique: true, using: :btree

end
