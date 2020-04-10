class Transfer < ApplicationRecord
  belongs_to :beneficiary
  belongs_to :bank_transaction
end
