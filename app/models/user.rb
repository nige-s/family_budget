class User < ActiveRecord::Base 

  has_many :accounts, :through => :account_holders
  has_many :account_holders
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
