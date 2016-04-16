json.ignore_nil!
json.(answer, :id, :question_id, :body, :votes, :created_at, :updated_at)

json.owner do
  json.(answer.user, :email, :country, :city, :address)
end
