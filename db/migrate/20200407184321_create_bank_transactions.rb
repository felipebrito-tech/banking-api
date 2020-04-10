class CreateBankTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :bank_transactions do |t|
      t.string :operation
      t.datetime :date
      t.string :summary
      t.numeric :amount
      t.references :account, foreign_key: true

      t.timestamps
    end
  end
end
