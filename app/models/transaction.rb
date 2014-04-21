class Transaction < ActiveRecord::Base
  before_save :ensure_lowercase
	belongs_to :account
	belongs_to :user
	belongs_to :category

  validates_presence_of :user_id
  validates :sign, :inclusion => { :in => %w(debit credit),
       :message => "%{value} is not a valid transaction type" }

  def correct_sign
    if sign == 'debit' && self.amount >= 0
      self.amount = -(self.amount)
    end
  end
  def ensure_lowercase
    self.description = self.description.downcase
    self.supplier = self.supplier.downcase
  end

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
