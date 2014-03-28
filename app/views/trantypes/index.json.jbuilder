json.array!(@trantypes) do |trantype|
  json.extract! trantype, :id, :name, :desc
  json.url trantype_url(trantype, format: :json)
end
