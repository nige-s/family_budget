json.array!(@account_transactions) do |account_transaction|
  json.extract! account_transaction, :id, :account_id, :tran_date, :description, :amount, :sign
  json.url account_transaction_url(account_transaction, format: :json)
end
