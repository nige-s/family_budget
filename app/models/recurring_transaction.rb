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
     # date = c_date.split('/')  
      puts "day #{c_date.day}"
	    todo_today = recurring_trans.where(day: c_date.day)
      #edate = end_date.split('/')
     #mydate = DateTime.parse(end_date)
      todo_today.each do |recurr_tran|
        t = Transaction.where(tran_date: c_date).where(amount: recurr_tran.amount).where(description: recurr_tran.description)
	@date_until = recurr_tran.end_date || nil
        if(@date_until.nil?)
	  Transaction.create(account_id: recurr_tran.account_id,
	               	     user_id: user_id,
			     tran_date: c_date,
			     description: recurr_tran.description,
			     amount: recurr_tran.amount,
			     sign: recurr_tran.sign) if t.empty?   

	elsif (recurr_tran.end_date >= end_date)
	  Transaction.create(account_id: recurr_tran.account_id,
	               	     user_id: user_id,
			     tran_date: c_date,
			     description: recurr_tran.description,
			     amount: recurr_tran.amount,
			     sign: recurr_tran.sign) if t.empty?   

	end
	end
    end
  end
end

