json.array!(@relation_enrachate_tiras) do |relation_enrachate_tira|
  json.extract! relation_enrachate_tira, :id, :enrachate_id, :tira_enrachate_id
  json.url relation_enrachate_tira_url(relation_enrachate_tira, format: :json)
end
