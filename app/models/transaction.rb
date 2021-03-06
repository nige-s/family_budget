class Transaction < ActiveRecord::Base
  before_save :ensure_lowercase, :set_reconciled_date
  belongs_to :account
  belongs_to :user
  belongs_to :category

  validates_presence_of :user_id, :category_id,:account_id,:amount, :sign
  validates :sign, :inclusion => { :in => %w(debit credit),
    :message => "%{value} is not a valid transaction type" }

  def correct_sign
    if sign == 'debit' && self.amount >= 0
      self.amount = -(self.amount)
    end
  end
  def ensure_lowercase
    self.description = self.description.downcase unless self.description.blank?
    self.supplier = self.supplier.downcase unless self.supplier.blank?
  end

  def self.user_transactions(curr_user)
    if(curr_user.id == 1 || curr_user.id ==2)
      categories = User.find(1).categories
      Transaction.where(user_id: [1, 2]).where(category_id: categories).order('tran_date DESC')
    else
      categories = User.find(curr_user.id).categories
      Transaction.where(user_id: curr_user.id).order('tran_date DESC')
    end
  end

  def self.sum_transactions(transactions)
    transactions.sum(:amount)
  end

  def set_reconciled_date
    if self.reconciled && self.reconciled_date.nil?
      self.reconciled_date = DateTime.now
    elsif self.reconciled == false && self.reconciled_date.nil? == false
      self.reconciled_date = nil
    end
end
  #paginates_per 10
end
