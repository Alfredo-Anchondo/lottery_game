json.array!(@enrachate_users) do |enrachate_user|
  json.extract! enrachate_user, :id, :question_enrachate_id, :tira_enrachate_id, :answer, :user_id, :status, :purchase_date
  json.url enrachate_user_url(enrachate_user, format: :json)
end
