json.array!(@topics) do |topic|
  json.extract! topic, :id, :term
  json.url topic_url(topic, format: :json)
end
