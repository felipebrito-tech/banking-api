class Beneficiary < ApplicationRecord
  validates :beneficiary_name, presence: true
  validates :document, presence: true
  validates :account_number, presence: true
  validates :account_digit, presence: true
  validates :bank_branch, presence: true

  belongs_to :bank
end
