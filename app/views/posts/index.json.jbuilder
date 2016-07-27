json.array!(@posts) do |post|
  json.extract! post, :id, :context
  json.url post_url(post, format: :json)
end
