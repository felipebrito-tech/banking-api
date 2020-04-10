class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.integer :number
      t.integer :digit
      t.integer :bank_branch
      t.numeric :balance
      t.references :bank, foreign_key: true

      t.timestamps
    end
  end
end
