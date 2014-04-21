class Statement < ActiveRecord::Base
  after_initialize :a_initialize
  def a_initialize
    self.edate ||= Date.today if new_record?
  end
	def self.account_balance(statement)
	  tmp_account = Account.find(statement.acc_id)
	  {start_balance: tmp_account.starting_balance, 
	   credits: tmp_account.transactions.where("tran_date <= ?", statement.edate).where(sign: "credit").sum(:amount),
	   debits: tmp_account.transactions.where("tran_date <= ?", statement.edate).where(sign: "debit").sum(:amount)}
	end
end