class RecurringTransaction < ActiveRecord::Base

	validates :day, :inclusion => { :in => (1..31), :message => "%{value} is not a a valid day" }

	validates :sign, :inclusion => { :in => %w(debit credit),
		:message => "%{value} is not a valid transaction type" }
end
