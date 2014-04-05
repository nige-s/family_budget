class AccountTransaction < ActiveRecord::Base
  belongs_to :account
	validates :sign, :inclusion => { :in => %w(debit credit),
	     :message => "%{value} is not a valid transaction type" }
end
