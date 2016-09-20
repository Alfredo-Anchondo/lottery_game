json.array!(@question_enrachates) do |question_enrachate|
  json.extract! question_enrachate, :id, :title, :answer1, :answer2, :program_date
  json.url question_enrachate_url(question_enrachate, format: :json)
end
