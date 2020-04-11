class Deposit < ApplicationRecord
  validate :validates_operation

  belongs_to :bank_transaction

  def make
  	result = account.deposit(amount)

  	if result[:success]
  		{success: save, message: ""}
  	else
  		result
  	end
  end

  def account
  	self.bank_transaction.account
  end

  def amount
  	self.bank_transaction.amount
  end

  def operation
  	self.bank_transaction.operation
  end

  def Deposit.new_deposit(amount, summary, account)
  	if amount.is_a? Numeric and account.is_a? Account
	  	bank_transaction = BankTransaction.new(
	  							operation: BankTransaction::DEPOSIT,
	  							amount: amount,
	  							summary: summary,
	  							account: account)

	  	Deposit.new(bank_transaction: bank_transaction)
	else
		nil
	end
  end

  def validates_operation
  	if self.bank_transaction.present? and operation != BankTransaction::DEPOSIT
  		errors.add(:bank_transaction_operation, "invalid operation for deposit")
  	end
  end
end
