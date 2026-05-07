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

ActiveRecord::Schema[8.1].define(version: 2026_05_06_180218) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "city", default: "Baltimore"
    t.boolean "claimed", default: false, null: false
    t.string "country", default: "US"
    t.datetime "created_at", null: false
    t.string "crunchbase_url"
    t.text "description"
    t.string "employee_count_bucket"
    t.integer "founded_year"
    t.string "github_url"
    t.datetime "last_verified_at"
    t.string "linkedin_url"
    t.string "logo_url"
    t.string "meta_description"
    t.string "meta_title"
    t.string "name", null: false
    t.string "primary_category", null: false
    t.string "slug", null: false
    t.string "source", default: "curator"
    t.string "state", default: "MD"
    t.string "status", default: "draft", null: false
    t.string "tagline"
    t.string "twitter_url"
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "website"
    t.index ["claimed"], name: "index_companies_on_claimed"
    t.index ["primary_category"], name: "index_companies_on_primary_category"
    t.index ["slug"], name: "index_companies_on_slug", unique: true
    t.index ["status"], name: "index_companies_on_status"
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "company_tags", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.bigint "tag_id", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id", "tag_id"], name: "index_company_tags_on_company_id_and_tag_id", unique: true
    t.index ["company_id"], name: "index_company_tags_on_company_id"
    t.index ["tag_id"], name: "index_company_tags_on_tag_id"
  end

  create_table "guides", force: :cascade do |t|
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.text "intro"
    t.string "meta_description"
    t.string "meta_title"
    t.datetime "published_at"
    t.string "slug", null: false
    t.string "status", default: "draft", null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["published_at"], name: "index_guides_on_published_at"
    t.index ["slug"], name: "index_guides_on_slug", unique: true
    t.index ["status"], name: "index_guides_on_status"
  end

  create_table "profile_claims", force: :cascade do |t|
    t.string "claimant_name"
    t.string "claimant_role"
    t.bigint "company_id", null: false
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.string "current_step", default: "verify", null: false
    t.string "email", null: false
    t.string "review_status", default: "pending", null: false
    t.datetime "reviewed_at"
    t.string "reviewed_by"
    t.datetime "updated_at", null: false
    t.string "verification_code_digest"
    t.datetime "verification_code_sent_at"
    t.string "verification_method"
    t.integer "verification_sends_count", default: 0, null: false
    t.datetime "verified_at"
    t.index ["company_id", "email"], name: "index_profile_claims_on_company_id_and_email", unique: true
    t.index ["company_id"], name: "index_profile_claims_on_company_id"
    t.index ["review_status"], name: "index_profile_claims_on_review_status"
  end

  create_table "resources", force: :cascade do |t|
    t.string "city", default: "Baltimore"
    t.string "country", default: "US"
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "founded_year"
    t.string "logo_url"
    t.string "meta_description"
    t.string "meta_title"
    t.string "name", null: false
    t.string "resource_type", null: false
    t.string "slug", null: false
    t.string "state", default: "MD"
    t.string "status", default: "draft", null: false
    t.string "tagline"
    t.datetime "updated_at", null: false
    t.string "website"
    t.index ["resource_type"], name: "index_resources_on_resource_type"
    t.index ["slug"], name: "index_resources_on_slug", unique: true
    t.index ["status"], name: "index_resources_on_status"
  end

  create_table "tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_tags_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "role", default: "owner", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "companies", "users"
  add_foreign_key "company_tags", "companies"
  add_foreign_key "company_tags", "tags"
  add_foreign_key "profile_claims", "companies"
end
