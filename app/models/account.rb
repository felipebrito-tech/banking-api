class Account < ApplicationRecord
  validates :number, presence: true
  validates :digit, presence: true
  validates :bank_branch, presence: true
  validates :balance, presence: true

  belongs_to :bank
  has_many :bank_transactions

  def Account.get_balance(account_id)
  	begin
  		Account.find(account_id).balance
  	rescue ActiveRecord::RecordNotFound
  		nil
  	end
  end

  def Account.bank_transactions(account_id, start_date, end_date)
  	date_format = /^\d{4}[\.](0?[1-9]|1[012])[\.](0?[1-9]|[12][0-9]|3[01])$/

  	puts date_format.match(end_date).to_s

  	if date_format.match(start_date) and date_format.match(end_date)
	  	begin
	  	  	account = Account.find(account_id)

	  	  	account.bank_transactions.where("date >= ? and date <= ?", start_date, end_date)
	  	rescue
	  		nil
	  	end
	else
		[]
	end
  end
end
