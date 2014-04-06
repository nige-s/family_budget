class AccountTransaction < ActiveRecord::Base
  before_save :correct_sign
  belongs_to :account
	validates :sign, :inclusion => { :in => %w(debit credit),
	     :message => "%{value} is not a valid transaction type" }

  def correct_sign
  	if sign == 'debit' 
  	self.amount = -(self.amount)
  	end
  end
end
