class CreateTags < ActiveRecord::Migration[8.1]
  def change
    create_table :tags do |t|
      t.string :slug, null: false
      t.string :name, null: false

      t.timestamps
    end
    add_index :tags, :slug, unique: true
  end
end
