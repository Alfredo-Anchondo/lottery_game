json.array!(@relation_tira_questions) do |relation_tira_question|
  json.extract! relation_tira_question, :id, :tira_enrachate_id, :question_enrachate_id
  json.url relation_tira_question_url(relation_tira_question, format: :json)
end
