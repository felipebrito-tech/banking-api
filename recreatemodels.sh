rails d model Transfer
rails d model Deposit
rails d model BankTransaction
rails d model Beneficiary
rails d model Account
rails d model Bank


rails generate model Bank bank_name number:integer
rails generate model Account number:integer digit:integer bank_branch:integer balance:numeric bank:references
rails generate model Beneficiary beneficiary_name document account_number:integer account_digit:integer bank_branch:integer bank:references
rails generate model BankTransaction operation date:datetime summary amount:numeric account:references
rails generate model Deposit bank_transaction:references
rails generate model Transfer beneficiary:references bank_transaction:references
