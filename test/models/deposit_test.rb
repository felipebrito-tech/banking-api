require 'test_helper'

class DepositTest < ActiveSupport::TestCase

  test "deposit data is invalid" do
  	deposit = Deposit.new

    assert_not deposit.valid?
  end

  test "deposit operation is invalid" do
  	deposit = Deposit.new(bank_transaction:
  							new_fake_bank_transaction(BankTransaction::TED))

    assert_not deposit.valid?
  end

  test "new deposit with invalid value returns nil" do
  	assert_nil Deposit.new_deposit(nil, nil, nil)
    assert_nil Deposit.new_deposit(100, nil, nil)
    assert_nil Deposit.new_deposit(nil, nil, load_may_account)
    assert_nil Deposit.new_deposit("", nil, load_may_account)
    assert_nil Deposit.new_deposit([], nil, load_may_account)
  end

  test "deposit data is valid" do
  	deposit = new_fake_deposit

    assert deposit.valid?
  end

  test "make deposit with negative amount returns false and message" do
  	deposit = Deposit.new_deposit(-100, nil, load_may_account)

  	result = deposit.make

    assert_not result[:success]
    assert_equal result[:message], "You can't deposit zero or negative values!"
  end

  test "make a deposit works fine" do
  	deposit = new_fake_deposit

  	result = deposit.make

  	assert result[:success]
  	assert_equal load_may_account.balance, 100
  end
end
