json.array!(@lotteries) do |lottery|
  json.extract! lottery, :id, :initial_balance, :rules, :description, :game_id, :winner_number, :initial_number, :final_number, :price
  json.url lottery_url(lottery, format: :json)
end
