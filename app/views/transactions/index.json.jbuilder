json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :user_id, :tran_date, :trantype_id, :category_id, :description, :supplier, :amount
  json.url transaction_url(transaction, format: :json)
end
