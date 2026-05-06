class CreateCompanies < ActiveRecord::Migration[8.1]
  def change
    create_table :companies do |t|
      t.string :slug, null: false
      t.string :name, null: false
      t.string :tagline
      t.text :description
      t.string :website
      t.string :linkedin_url
      t.string :github_url
      t.string :crunchbase_url
      t.string :twitter_url
      t.string :city, default: "Baltimore"
      t.string :state, default: "MD"
      t.string :country, default: "US"
      t.integer :founded_year
      t.string :employee_count_bucket
      t.string :primary_category, null: false
      t.string :logo_url
      t.string :status, null: false, default: "draft"
      t.boolean :claimed, null: false, default: false
      t.references :user, foreign_key: true
      t.datetime :last_verified_at
      t.string :meta_title
      t.string :meta_description
      t.string :source, default: "curator"

      t.timestamps
    end

    add_index :companies, :slug, unique: true
    add_index :companies, :status
    add_index :companies, :primary_category
    add_index :companies, :claimed
  end
end
