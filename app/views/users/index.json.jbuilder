json.array!(@users) do |user|
  json.extract! user, :id, :avatar, :birthday, :country, :city, :address
  json.url user_url(user, format: :json)
end
