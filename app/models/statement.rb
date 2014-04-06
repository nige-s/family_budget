class Statement < ActiveRecord::Base
  after_initialize :a_initialize
  def a_initialize
    self.edate ||= Date.today if new_record?
  end
	def self.account_balance(account_id)
	  tmp_account = Account.find(account_id)
	  tmp_account.starting_balance + tmp_account.account_transactions.sum(:amount)
	end
end