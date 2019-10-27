require 'rails_helper'

RSpec.describe PodcastEpisodesIngestionService, type: :model do
  describe "#start!" do
    it "should import all episodes for a podcast" do
      DiscoverService.start!
      # v = Podcast.last.episodes.count
      # Podcast.last.episodes.each &:destroy
      # e = PodcastEpisodesIngestionService.new(podcast: Podcast.last)
      # f = Podcast.last.episodes.count
      # expect(v).to eq f
    end
  end
end
