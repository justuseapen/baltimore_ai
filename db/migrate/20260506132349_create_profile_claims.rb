class CreateProfileClaims < ActiveRecord::Migration[8.1]
  def change
    create_table :profile_claims do |t|
      t.references :company, null: false, foreign_key: true
      t.string :email, null: false
      t.string :verification_code_digest
      t.datetime :verification_code_sent_at
      t.integer :verification_sends_count, null: false, default: 0
      t.datetime :verified_at
      t.string :verification_method
      t.string :review_status, null: false, default: "pending"
      t.string :reviewed_by
      t.datetime :reviewed_at
      t.string :claimant_name
      t.string :claimant_role
      t.string :current_step, null: false, default: "verify"
      t.datetime :completed_at

      t.timestamps
    end

    add_index :profile_claims, [ :company_id, :email ], unique: true
    add_index :profile_claims, :review_status
  end
end
