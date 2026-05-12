class CreateContactMessages < ActiveRecord::Migration[8.1]
  def change
    create_table :contact_messages do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :subject
      t.text :body, null: false
      t.string :ip_address
      t.string :user_agent

      t.timestamps
    end

    add_index :contact_messages, :created_at
  end
end
