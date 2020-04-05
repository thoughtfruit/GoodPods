class Creators::EpisodeCreationService
  
  def self.for(podcast:)
    @@podcast = podcast
    self
  end
  
  def self.with(episode:)
    item = episode
    episode = @@podcast.episodes.find_or_create_by(
      title: item.at('title').try(:content),
    )
    episode.update!(
      description: item.at('description').try(:content),
      published: true,
      published_at: item.at('pubDate').try(:content),
      streaming_url: item.at('enclosure').attr('url'),
      guid: item.at('guid').try(:content)
    ) if episode
    puts "Saved episode #{item.at('title').try(:content)}".green
  end
  
end
