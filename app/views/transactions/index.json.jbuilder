json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :user_id, :tran_date, :account_id, :category_id, :description, :supplier, :amount, :sign
  json.url transaction_url(transaction, format: :json)
end
