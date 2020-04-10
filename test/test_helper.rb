ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def create_fake_account
  	bank = Bank.first
  	
  	Account.new(
  				number: 21233,
  				digit: 3,
  				bank_branch: 3344,
  				balance: 2300,
  				bank: bank)
  end

  def load_may_account()
    may_account = accounts(:May)

    Account.get(may_account.bank_branch, may_account.number, may_account.digit)
  end
end
