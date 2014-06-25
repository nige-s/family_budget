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

    #process_monthly_recurring(account_id, end_date, start_date, user_id)
    process_weekly_recurring(account_id, end_date, start_date, user_id)
  end

  def self.process_weekly_recurring(account_id, end_date, start_date, user_id)
    week_day = {1 => 'monday', 2 => 'tuesday', 3 => 'wednesday', 4 => 'thursday', 5 => 'friday', 6 => 'saturday', 7 => 'sunday'}

    recurring_trans = RecurringTransaction.where(active: true).where(account_id: account_id).where(interval: 'weekly').where('start_date <= ?', start_date)
    (start_date..end_date).each do |date|
      recurring_trans.each do |recurring_transaction|
        @date_until = recurring_transaction.end_date || nil
        create_tran = false
        if(date.monday? && recurring_transaction.day == 1)
          create_tran = true
        elsif(date.tuesday? && recurring_transaction.day == 2)
          create_tran = true
        elsif(date.wednesday? && recurring_transaction.day == 3)
          create_tran = true
        elsif(date.thursday? && recurring_transaction.day == 4)
          create_tran = true
        elsif(date.friday? && recurring_transaction.day == 5)
          create_tran = true
        elsif(date.saturday? && recurring_transaction.day == 6)
          create_tran = true
        elsif(date.sunday? && recurring_transaction.day == 7)
          create_tran = true
        end

        if (create_tran && weekly_recurring_transaction_exists(recurring_transaction.id, date) == false && (@date_until.nil? || @date_until >= end_date) && recurring_transaction.start_date <= date)

          Transaction.create(account_id: recurring_transaction.account_id,
                             user_id: user_id,
                             tran_date: date,
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

  def self.process_monthly_recurring(account_id, end_date, start_date, user_id)
    recurring_trans = RecurringTransaction.where(active: true).where(account_id: account_id).where(interval: 'monthly').where('start_date <= ?', start_date)
    (start_date.month..end_date.month).each do |month|
      recurring_trans.each do |recurring_transaction|
        @date_until = recurring_transaction.end_date || nil
        begin
          @curr_date = Date.strptime("#{recurring_transaction.day}/#{month}/#{start_date.year}", "%d/%m/%Y")
        rescue
          puts "INVALID DATE: #{recurring_transaction.day}/#{month}/#{start_date.year}"
        end
        if (monthly_recurring_transaction_exists(recurring_transaction.id, month, start_date.year) == false && (@date_until.nil? || @date_until >= end_date) && recurring_transaction.start_date <= @curr_date)

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

  def self.monthly_recurring_transaction_exists(id,month,year)
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

  def self.weekly_recurring_transaction_exists(id,date)
    trans = Transaction.where(recurring_trans_id: id )
    exists = false
    if(trans.nil? == false)
      trans.all.each do |tran|
        if(tran.tran_date == date)
          exists = true
          break
        end
      end
    end
    exists
  end
  end

