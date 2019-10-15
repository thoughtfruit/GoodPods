json.podcasts do
  json.array!(@podcasts) do |podcast|
    json.id podcast.id
    json.title podcast.title
  end
end
