json.array!(@lotteries) do |lottery|
  json.extract! lottery, :id, :initial_balance, :rules, :description, :game_id, :team, :team2, :winner_number, :initial_number, :final_number, :price, :game
  json.url lottery_url(lottery, format: :json)
end


