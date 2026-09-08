class AddResearchProvenance < ActiveRecord::Migration[8.1]
  def change
    %i[companies resources guides].each do |table|
      add_column table, :reviewed_on, :date
      add_column table, :source_references, :jsonb, default: [], null: false
    end
    add_column :companies, :location_note, :string
    add_column :resources, :location_note, :string
  end
end
