class Transaction < ActiveRecord::Base
	belongs_to :trantype
	belongs_to :user
	belongs_to :category

  validates_presence_of :user_id
def self.user_transactions(curr_user)
  if(curr_user.id == 1 || curr_user.id ==2)
    Transaction.where(user_id: [1, 2]).order('tran_date DESC')
  else
    Transaction.where(user_id: curr_user.id).order('tran_date DESC')
  end
end

def self.sum_transactions(transactions)
  transactions.sum(:amount)
end
	#paginates_per 10
end
