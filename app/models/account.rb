class Account < ApplicationRecord
  DATE_FORMAT = /^\d{4}[\.](0?[1-9]|1[012])[\.](0?[1-9]|[12][0-9]|3[01])$/
  
  validates :number, presence: true
  validates :digit, presence: true
  validates :bank_branch, presence: true
  validates :balance, presence: true

  belongs_to :bank
  has_many :bank_transactions

  def deposit(amount)
  	self.balance += amount

  	save
  end

  def list_bank_transactions(start_date, end_date)
  	if Account.is_valid(start_date) and Account.is_valid(end_date)
  	  	bank_transactions.where("date >= ? and date <= ?", start_date, end_date)
	else
		[]
	end
  end

  def Account.get(bank_branch, number, digit)
  	Account.where(bank_branch: bank_branch, number: number, digit: digit).take
  end

  private
	  def Account.is_valid(date_string)
	  	DATE_FORMAT.match(date_string)
	  end
end
