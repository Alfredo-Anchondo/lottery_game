json.array!(@gift_cards) do |gift_card|
  json.extract! gift_card, :id, :value, :user_id, :code, :available
  json.url gift_card_url(gift_card, format: :json)
end
