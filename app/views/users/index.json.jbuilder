json.array!(@users) do |user|
  json.extract! user, :id, :uid, :email, :name, :provider
  json.url user_url(user, format: :json)
end
