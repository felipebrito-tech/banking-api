require 'test_helper'

class AccountTest < ActiveSupport::TestCase

  test "account data is invalid" do
  	account = Account.new

    assert_not account.valid?
  end

  test "account data is valid" do
    assert create_fake_account.valid?
  end

  test "get account with invalid data returns nil" do
    account = Account.get(1, 1, 1)

    assert_nil account
  end

  test "get account works fine" do
    account = load_may_account()

    assert_not_nil account
  end

  test "get account balance works fine" do
    account = load_may_account()

    assert_equal account.balance, 50
  end

  test "get bank transactions returns the right size" do
    account = load_may_account()

    bank_transactions = account.bank_transactions

    assert_equal bank_transactions.size, 2
  end

  test "list bank transactions with invalid period returns none" do
    account = load_may_account()

    bank_transactions = account.list_bank_transactions("2020.04.01", "2020.03.31")

    assert_equal bank_transactions.size, 0
  end

  test "list bank transactions with invalid date format returns none" do
    account = load_may_account()

    bank_transactions = account.list_bank_transactions("2020", "2020.03.31")

    assert_equal bank_transactions.size, 0
  end

  test "list bank transactions by period works" do
    account = load_may_account()

    bank_transactions = account.list_bank_transactions("2020.03.01", "2020.03.31")

    assert_equal bank_transactions.size, 1
  end

  test "call deposit with invalid values returns nil" do
    account = load_may_account()

    assert_nil account.deposit(-300)
    assert_nil account.deposit(nil)
    assert_nil account.deposit("whatever")
    assert_nil account.deposit([])
  end

  test "making a deposit works fine" do
    account = load_may_account()

    account.deposit(300)

    assert_equal load_may_account().balance, 350
  end

  test "making a withdrawal with invalid values returns nil" do
    account = load_may_account()

    assert_nil account.withdrawal(100)
    assert_nil account.withdrawal(-100)
    assert_nil account.withdrawal(nil)
    assert_nil account.withdrawal("whatever")
    assert_nil account.withdrawal([])
  end

  test "making a withdrawal works fine" do
    account = load_may_account()

    account.withdrawal(10)

    assert_equal load_may_account().balance, 40
  end
end
