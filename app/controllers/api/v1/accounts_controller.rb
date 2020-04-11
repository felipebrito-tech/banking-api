class Api::V1::AccountsController < ApplicationController

	# POST api/v1/accounts/balance
	def balance
		account = get_account(params)

		if account.present?
			render json: {balance: account.balance}, status: :ok
		else
			render status: :bad_request
		end
	end

	# POST api/v1/accounts/statement
	def statement
		account = get_account(params)
		bank_transactions = account.list_bank_transactions(params[:start_date], params[:end_date])

		if account.present?
			render json: {transactions: bank_transactions}, status: :ok
		else
			render status: :bad_request
		end
	end

	# PUT api/v1/accounts/deposit
	def deposit
		account = get_account(params)

		if account.present?
			deposit = Deposit.new_deposit(
									params[:amount].to_f,
									params[:summary],
									account)
			result = deposit.make

			if result[:success]
				balance = account.reload.balance

				render json: {balance: balance}, status: :ok
			else
				render json: {message: result[:message]}, status: :bad_request
			end
		else
			render status: :bad_request
		end
	end

	# POST api/v1/accounts/transfer
	def transfer
		account = get_account(params)
		beneficiary = get_beneficiary(params)

		if account.present?
			transfer = Transfer.new_transfer(
									params[:amount].to_f,
									params[:summary],
									account,
									beneficiary)
			result = transfer.make

			if result[:success]
				balance = account.reload.balance
				bank_transaction = transfer.reload.bank_transaction

				render json: {balance: balance, transaction_id: bank_transaction.id}, status: :ok
			else
				render json: {message: result[:message]}, status: :bad_request
			end
		else
			render status: :bad_request
		end
	end

	def get_account(params)
		Account.get(params[:bank_branch], params[:number], params[:digit])
	end

	def get_beneficiary(params)
		bank = Bank.new(
					bank_name: params[:beneficiary_bank_name],
					number: params[:beneficiary_bank_number])
  	
  		Beneficiary.new(
  				beneficiary_name: params[:beneficiary_name],
  				document: params[:beneficiary_document],
  				account_number: params[:beneficiary_account_number],
  				account_digit: params[:beneficiary_account_digit],
  				bank_branch: params[:beneficiary_bank_branch],
  				bank: bank)
  	end
end
