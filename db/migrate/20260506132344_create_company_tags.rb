class CreateCompanyTags < ActiveRecord::Migration[8.1]
  def change
    create_table :company_tags do |t|
      t.references :company, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end

    add_index :company_tags, [ :company_id, :tag_id ], unique: true
  end
end
