class RecurringTransaction < ActiveRecord::Base
	belongs_to :account
	validates :day, :inclusion => { :in => (1..31), :message => "%{value} is not a a valid day" }

	validates :sign, :inclusion => { :in => %w(debit credit),
		:message => "%{value} is not a valid transaction type" }
  
  def self.process_recurring(options={})
    start_date = Date.parse(options[:sdate])
    end_date = Date.parse(options[:edate]) 
    account_id = options[:account_id]
    user_id = Account.find(account_id).users.first.id
    
    recurring_trans = RecurringTransaction.where(active: true).where(account_id: account_id).where('start_date >= ?', start_date)
   
    (start_date..end_date).each do |c_date|
      todo_today = recurring_trans.where(day: c_date.day)
      
      todo_today.each do |recurr_tran|
        t = Transaction.where(tran_date: c_date).where(description: recurr_tran.description.downcase)
	@date_until = recurr_tran.end_date || nil
        if(@date_until.nil? || recurr_tran.end_date >= end_date)
	  Transaction.create(account_id: recurr_tran.account_id,
	               	     user_id: user_id,
			     tran_date: c_date,
			     category_id: recurr_tran.category_id,
			     description: recurr_tran.description,
			     amount: recurr_tran.amount,
			     sign: recurr_tran.sign) if t.empty?   

	end
      end
    end
  end
end

