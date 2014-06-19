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
    (start_date.month..end_date.month).each do |month|
      recurring_trans.each do |recurring_transaction|
        @date_until = recurring_transaction.end_date || nil
        @curr_date = Date.parse("#{start_date.year}/#{month}/#{recurring_transaction.day}")
        if(recurring_transaction_exists(recurring_transaction.id,month,start_date.year) == false && (@date_until.nil? || @date_until >= end_date) && recurring_transaction.start_date <= @curr_date)

        Transaction.create(account_id: recurring_transaction.account_id,
                       	   user_id: user_id,
                           tran_date: @curr_date,
                           category_id: recurring_transaction.category_id,
                           description: recurring_transaction.description,
                           amount: recurring_transaction.amount,
                           sign: recurring_transaction.sign,
                           recurring_trans_id: recurring_transaction.id)
          recurring_transaction.last_updated = Date.today
          recurring_transaction.save
          end
      end
    end
  end

  def self.recurring_transaction_exists(id,month,year)
    trans = Transaction.where(recurring_trans_id: id )
    exists = false
    if(trans.nil? == false)
      trans.all.each do |tran|
        if(tran.tran_date.month == month && tran.tran_date.year == year)
          exists = true
          break
        end
      end
    end
    exists
  end
  end

