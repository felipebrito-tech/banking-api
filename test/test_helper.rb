ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def new_fake_account
  	bank = Bank.first
  	
  	Account.new(
  				number: 21233,
  				digit: 3,
  				bank_branch: "3344",
  				balance: 2300,
  				bank: bank)
  end

  def load_may_account()
    may_account = accounts(:May)

    Account.get(may_account.bank_branch, may_account.number, may_account.digit)
  end

  def new_fake_beneficiary
  	bank = Bank.first
  	
  	Beneficiary.new(
  				beneficiary_name: "Steve Rogers",
  				document: "11122233344",
  				account_number: 11223,
  				account_digit: 5,
  				bank_branch: "1102",
  				bank: bank)
  end

  def new_fake_bank_transaction(operation)
  	account = Account.first
  	
  	BankTransaction.new(
  				operation: operation,
  				amount: 30,
  				summary: "Compra de USD 1,00",
  				account: account)
  end

  def new_fake_deposit
  	account = load_may_account

  	Deposit.new_deposit(50, "Bebidas", account)
  end

  def new_fake_transfer
  	account = load_may_account
  	beneficiary = new_fake_beneficiary

  	Transfer.new_transfer(50, "Tinta pro novo escudo", account, beneficiary)
  end
end
