json.array!(@bank_transfers) do |bank_transfer|
  json.extract! bank_transfer, :id, :src_account_id, :target_account_id, :tran_date, :amount, :description, :src_user_id, :target_user_id
  json.url bank_transfer_url(bank_transfer, format: :json)
end
