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

ActiveRecord::Schema.define(version: 20191021084316) do

  create_table "articles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "genre"
    t.string "image"
    t.string "sweet_name"
    t.index ["user_id", "created_at"], name: "index_articles_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_articles_on_user_id"
  end

  create_table "likes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "like_user_id"
    t.integer "liked_article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["like_user_id", "liked_article_id"], name: "index_likes_on_like_user_id_and_liked_article_id", unique: true
    t.index ["like_user_id"], name: "index_likes_on_like_user_id"
    t.index ["liked_article_id"], name: "index_likes_on_liked_article_id"
  end

  create_table "stocks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "stock_user_id"
    t.integer "stocked_article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_user_id", "stocked_article_id"], name: "index_stocks_on_stock_user_id_and_stocked_article_id", unique: true
    t.index ["stock_user_id"], name: "index_stocks_on_stock_user_id"
    t.index ["stocked_article_id"], name: "index_stocks_on_stocked_article_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.string "image"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "articles", "users"
end
