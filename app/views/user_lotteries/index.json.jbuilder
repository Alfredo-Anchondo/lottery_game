json.array!(@user_lotteries) do |user_lottery|
  json.extract! user_lottery, :id, :user_id, :lottery_id, :status, :ticket_number, :purchase_date
  json.url user_lottery_url(user_lottery, format: :json)
end
