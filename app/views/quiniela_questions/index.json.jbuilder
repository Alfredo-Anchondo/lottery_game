json.array!(@quiniela_questions) do |quiniela_question|
  json.extract! quiniela_question, :id
  json.url quiniela_question_url(quiniela_question, format: :json)
end
