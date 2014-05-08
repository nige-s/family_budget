class Account < ActiveRecord::Base
  has_many :transactions
  has_many :recurring_transactions
  
  has_many :users, :through => :account_holders
  has_many :account_holders

  def self.user_accounts(user_id)
  	accounts = []
    ah = AccountHolder.where(:user_id => user_id)
    ah.each do |acc|
      accounts << Account.find(acc.account_id)
    end
    accounts
  end

  def self.owns_account?(user_id,account_id)
    User.find(user_id).accounts.where(id: account_id).size > 0
  end
end
