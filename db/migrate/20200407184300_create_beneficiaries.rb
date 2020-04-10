class CreateBeneficiaries < ActiveRecord::Migration[5.2]
  def change
    create_table :beneficiaries do |t|
      t.string :beneficiary_name
      t.string :document
      t.integer :account_number
      t.integer :account_digit
      t.string :bank_branch
      t.references :bank, foreign_key: true

      t.timestamps
    end
  end
end
