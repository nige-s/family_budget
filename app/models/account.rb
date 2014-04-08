class Account < ActiveRecord::Base
  has_many :account_transactions
  has_many :recurring_transactions
  belongs_to :AccountHolder

  def self.user_accounts(user_id)
  	accounts = []
    ah = AccountHolder.where(:user_id => user_id)
    ah.each do |acc|
      accounts << Account.find(acc.account_id)
    end
    return accounts
  end
end
