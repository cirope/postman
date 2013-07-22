json.array!(@feedbacks) do |feedback|
  json.extract! feedback, :from, :score, :notes, :ticket_id
  json.url feedback_url(feedback, format: :json)
end
