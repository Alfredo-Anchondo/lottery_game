json.array!(@tira_enrachates) do |tira_enrachate|
  json.extract! tira_enrachate, :id, :program_date, :name
  json.url tira_enrachate_url(tira_enrachate, format: :json)
end
