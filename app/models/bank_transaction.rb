class BankTransaction < ApplicationRecord
  TED = "TED"
  DEPOSIT = "DEPOSIT"

  validates :operation, presence: true
  validates :amount, presence: true
  
  belongs_to :account, autosave: true
end
