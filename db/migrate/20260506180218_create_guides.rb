class CreateGuides < ActiveRecord::Migration[8.1]
  def change
    create_table :guides do |t|
      t.string :slug, null: false
      t.string :title, null: false
      t.text :intro
      t.text :body, null: false
      t.string :meta_title
      t.string :meta_description
      t.string :status, null: false, default: "draft"
      t.datetime :published_at

      t.timestamps
    end

    add_index :guides, :slug, unique: true
    add_index :guides, :status
    add_index :guides, :published_at
  end
end
