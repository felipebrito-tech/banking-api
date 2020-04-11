require 'test_helper'

class TransferTest < ActiveSupport::TestCase

  test "transfer data is invalid" do
  	transfer = Transfer.new

    assert_not transfer.valid?
  end

  test "transfer operation is invalid" do
  	transfer = Transfer.new(bank_transaction:
  								new_fake_bank_transaction(BankTransaction::DEPOSIT),
  							beneficiary:
  								new_fake_beneficiary)

    assert_not transfer.valid?
  end

  test "new transfer with invalid value returns nil" do
  	account = load_may_account
  	beneficiary = new_fake_beneficiary

  	assert_nil Transfer.new_transfer(nil, nil, nil, nil)
    assert_nil Transfer.new_transfer(100, nil, nil, nil)
    assert_nil Transfer.new_transfer(100, nil, account, nil)
    assert_nil Transfer.new_transfer(100, nil, nil, beneficiary)
    assert_nil Transfer.new_transfer(nil, nil, account, beneficiary)
    assert_nil Transfer.new_transfer("", nil, account, beneficiary)
    assert_nil Transfer.new_transfer([], nil, account, beneficiary)
  end

  test "transfer data is valid" do
  	transfer = new_fake_transfer

    assert transfer.valid?
  end

  test "make transfer with negative amount returns false and message" do
  	transfer = Transfer.new_transfer(-100, nil, load_may_account, new_fake_beneficiary)

  	result = transfer.make

    assert_not result[:success]
    assert_equal result[:message], "You can't withdrawal zero or negative amount!"
  end

  test "make transfer with amount greater than balance returns false and a message" do
    transfer = Transfer.new_transfer(100, nil, load_may_account, new_fake_beneficiary)

    result = transfer.make

    assert_not result[:success]
    assert_equal result[:message], "You have not enough balance to complete this withdrawal!"
  end

  test "make a transfer works fine" do
  	transfer = new_fake_transfer

  	result = transfer.make

  	assert result[:success]
  	assert_equal load_may_account.balance, 0
  end
end
