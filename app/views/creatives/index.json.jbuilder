json.array!(@creatives) do |creative|
  json.extract! creative, :title, :description, :votes, :user_id
  json.url creative_url(creative, format: :json)
end
