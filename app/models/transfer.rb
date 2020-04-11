class Transfer < ApplicationRecord
  validate :validates_operation

  belongs_to :beneficiary
  belongs_to :bank_transaction

  def make
  	result = account.withdrawal(amount)

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

  def Transfer.new_transfer(amount, summary, account, beneficiary)
  	if amount.is_a? Numeric and account.is_a? Account and beneficiary.is_a? Beneficiary
	  	bank_transaction = BankTransaction.new(
	  							operation: BankTransaction::TED,
	  							amount: amount,
	  							summary: summary,
	  							account: account)

	  	Transfer.new(beneficiary: beneficiary, bank_transaction: bank_transaction)
	else
		nil
	end
  end

  def validates_operation
  	if self.bank_transaction.present? and operation != BankTransaction::TED
  		errors.add(:bank_transaction_operation, "invalid operation for transfer")
  	end
  end
end
