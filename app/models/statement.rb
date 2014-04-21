class Statement < ActiveRecord::Base
  after_initialize :a_initialize
  def a_initialize
    self.edate ||= Date.today if new_record?
  end
	def self.account_balance(statement)
	  tmp_account = Account.find(statement.acc_id)
	  sb = tmp_account.starting_balance || 0
	  cred = tmp_account.transactions.where("tran_date <= ?", statement.edate).where(sign: "credit").sum(:amount) || 0
	  deb = tmp_account.transactions.where("tran_date <= ?", statement.edate).where(sign: "debit").sum(:amount) || 0
	  {start_balance: sb, 
	   credits: cred,
	   debits: deb}
	end
end