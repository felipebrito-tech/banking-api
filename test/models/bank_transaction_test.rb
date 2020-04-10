require 'test_helper'

class BankTransactionTest < ActiveSupport::TestCase

  test "bank transaction data is invalid" do
  	bank_transaction = BankTransaction.new

    assert_not bank_transaction.valid?
  end

  test "bank transaction data is valid" do
    assert create_fake_bank_transaction.valid?
  end
end
