json.array!(@statements) do |statement|
  json.extract! statement, :id, :acc_id, :sdate, :edate
  json.url statement_url(statement, format: :json)
end
