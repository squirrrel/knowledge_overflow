json.ignore_nil!
json.(question, :id, :header, :body, :views, :votes, :created_at, :updated_at)

json.owner do
  json.(question.user, :email, :country, :city, :address)
end

json.answers question.answers.each do |answer|
  json.(answer, :id) 
end
