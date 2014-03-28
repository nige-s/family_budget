json.array!(@users) do |user|
  json.extract! user, :id, :name, :desc
  json.url user_url(user, format: :json)
end
