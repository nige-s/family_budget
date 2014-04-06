class Statement < ActiveRecord::Base

	def self.account_balance(account_id)
	  tmp_account = Account.find(account_id)
	  tmp_account.starting_balance + tmp_account.account_transactions.sum(:amount)
	end
end
