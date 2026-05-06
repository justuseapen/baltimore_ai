class CreateResources < ActiveRecord::Migration[8.1]
  def change
    create_table :resources do |t|
      t.string :slug, null: false
      t.string :name, null: false
      t.string :tagline
      t.text :description
      t.string :website
      t.string :resource_type, null: false
      t.string :city, default: "Baltimore"
      t.string :state, default: "MD"
      t.string :country, default: "US"
      t.integer :founded_year
      t.string :logo_url
      t.string :status, null: false, default: "draft"
      t.string :meta_title
      t.string :meta_description

      t.timestamps
    end

    add_index :resources, :slug, unique: true
    add_index :resources, :status
    add_index :resources, :resource_type
  end
end
