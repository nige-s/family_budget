class User < ActiveRecord::Base 

  has_many :accounts,:through => :bank_transfers
  has_many :bank_transfers, :foreign_key => 'src_user_id'
  has_many :accounts, :through => :account_holders
  has_many :account_holders
  has_many :categories
  has_many :transactions

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
