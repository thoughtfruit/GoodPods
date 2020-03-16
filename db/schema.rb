# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_16_070737) do

  create_table "clusters", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "collections", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "episodes", force: :cascade do |t|
    t.string "episode"
    t.integer "podcast_id"
    t.string "title"
    t.text "description"
    t.boolean "published"
    t.string "episode_number"
    t.text "streaming_url"
    t.date "published_at"
    t.text "tags"
    t.integer "tier_required"
    t.text "guid"
    t.index ["podcast_id"], name: "index_episodes_on_podcast_id"
  end

  create_table "genres", force: :cascade do |t|
    t.integer "user_id"
    t.integer "podcast_id"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["podcast_id"], name: "index_genres_on_podcast_id"
    t.index ["user_id"], name: "index_genres_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "podcast_id"
    t.integer "genre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genre_id"], name: "index_groups_on_genre_id"
    t.index ["podcast_id"], name: "index_groups_on_podcast_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "update_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["update_id"], name: "index_likes_on_update_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "networks", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "podcasts", force: :cascade do |t|
    t.integer "network_id"
    t.integer "cluster_id"
    t.string "title"
    t.string "itunes_url"
    t.string "feed_url"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "logo_url"
    t.integer "ranking"
    t.text "bio"
    t.text "genre"
    t.text "logo_url_large"
    t.integer "collection_id"
    t.boolean "xml_valid"
    t.date "last_fetched_at"
    t.index ["cluster_id"], name: "index_podcasts_on_cluster_id"
    t.index ["network_id"], name: "index_podcasts_on_network_id"
  end

  create_table "updates", force: :cascade do |t|
    t.integer "user_id"
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "podcast_id"
    t.index ["podcast_id"], name: "index_updates_on_podcast_id"
    t.index ["user_id"], name: "index_updates_on_user_id"
  end

  create_table "user_podcast_statuses", force: :cascade do |t|
    t.integer "user_id"
    t.integer "podcast_id"
    t.text "status"
    t.index ["podcast_id"], name: "index_user_podcast_statuses_on_podcast_id"
    t.index ["user_id"], name: "index_user_podcast_statuses_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "episodes", "podcasts"
end
