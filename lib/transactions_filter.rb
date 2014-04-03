class TransactionsFilter

def user_transactions(curr_user)
  if(curr_user.id == 1 || curr_user.id ==2)
    Transaction.where(user_id: [1, 2]).order('tran_date DESC')
  else
    Transaction.where(user_id: curr_user.id).order('tran_date DESC')
  end
end
end