json.array!(@questions) do |question|
  json.extract! question, :id, :header, :views
  json.url question_url(question, format: :json)
end
