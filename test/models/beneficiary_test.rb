require 'test_helper'

class BeneficiaryTest < ActiveSupport::TestCase

  test "beneficiary data is invalid" do
  	beneficiary = Beneficiary.new

    assert_not beneficiary.valid?
  end

  test "beneficiary data is valid" do
    assert new_fake_beneficiary.valid?
  end

  test "saving beneficiary works fine" do
  	assert new_fake_beneficiary.save
  end
end
