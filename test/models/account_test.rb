require 'test_helper'

class AccountTest < ActiveSupport::TestCase

  test "account data is invalid" do
  	account = Account.new

    assert_not account.valid?
  end

  test "get account balance with an inexistent account id returns nil" do
    assert_nil Account.get_balance(100)
  end

  test "get account balance with valid id" do
    balance = Account.get_balance(305943810)

    assert_equal balance, 50
  end

  test "get bank transactions returns the right size" do
    bank_transactions = Account.first.bank_transactions

    assert_equal bank_transactions.size, 2
  end

  test "list bank transactions with invalid account id returns nil" do
      assert_nil Account.bank_transactions(100, "2020.03.01", "2020.03.31")
  end

  test "list bank transactions with invalid period returns none" do
      assert_equal Account.bank_transactions(305943810, "2020.04.01", "2020.03.31").size, 0
  end

  test "list bank transactions with invalid date format returns none" do
      assert_equal Account.bank_transactions(305943810, "2020", "2020.03.31").size, 0
  end

  test "list bank transactions by period works" do
    bank_transactions = Account.bank_transactions(305943810, "2020.03.01", "2020.03.31")

    assert_equal bank_transactions.size, 1
  end

  test "account data is valid" do
    assert create_fake_account.valid?
  end
end
