class BankTransfer < ActiveRecord::Base
validates_presence_of :src_user_id, :target_user_id, :tran_date, :src_account_id, :target_account_id, :amount
belongs_to :user,  :foreign_key => 'src_user_id'
belongs_to :account, :primary_key => 'src_account_id', :foreign_key => 'account_id'

  def self.process_transfer(bank_transfer)
    Transaction.create(user_id: bank_transfer.src_user_id, 
		       tran_date: bank_transfer.tran_date,
		       account_id: bank_transfer.src_account_id,
		       description: bank_transfer.description,
		       amount: bank_transfer.amount,
		       category_id:  Category.all.where(user_id: 0).where(group: 'account',name: 'TRANSFER').first.id,
		       sign: 'debit')
    
    Transaction.create(user_id: bank_transfer.target_user_id, 
		       tran_date: bank_transfer.tran_date,
		       account_id: bank_transfer.target_account_id,
		       description: bank_transfer.description,
		       amount: bank_transfer.amount,
		       category_id:  Category.all.where(user_id: 0).where(group: 'account',name: 'TRANSFER').first.id,
		       sign: 'credit')
  end 

end
