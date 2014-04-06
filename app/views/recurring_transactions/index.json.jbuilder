json.array!(@recurring_transactions) do |recurring_transaction|
  json.extract! recurring_transaction, :id, :account_id, :interval, :description, :amount, :sign, :active, :start_date, :end_date, :last_updated, :day
  json.url recurring_transaction_url(recurring_transaction, format: :json)
end
