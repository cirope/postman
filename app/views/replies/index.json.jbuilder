json.array!(@replies) do |reply|
  json.extract! reply, :body, :ticket_id
  json.url reply_url(reply, format: :json)
end
