json.array!(@rankings) do |ranking|
  json.extract! ranking, :id, :name, :tries, :game
  json.url ranking_url(ranking, format: :json)
end
