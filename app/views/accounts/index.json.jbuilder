json.array!(@accounts) do |account|
  json.extract! account, :id, :name, :starting_balance
  json.url account_url(account, format: :json)
end
