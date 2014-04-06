class Account < ActiveRecord::Base
  has_many :account_transactions
  has_many :recurring_transactions
end
