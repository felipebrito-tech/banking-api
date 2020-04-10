require 'test_helper'

class BankTest < ActiveSupport::TestCase

  test "bank data is invalid" do
  	bank = Bank.new

    assert_not bank.valid?
  end

  test "bank_name is already stored in db" do
  	bank = Bank.new(bank_name: "Trampolin", number:900)

  	assert_not bank.valid?
  end

  test "number is already stored in db" do
  	bank = Bank.new(bank_name: "Trampolindo", number:999)

  	assert_not bank.valid?
  end

  test "bank data is valid" do
  	bank = Bank.new(bank_name: "Trampo SA", number: 997)

  	assert bank.valid?
  end
end