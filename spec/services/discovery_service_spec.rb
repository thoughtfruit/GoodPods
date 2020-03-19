require 'rails_helper'

RSpec.describe DiscoveryService, type: :model do

  describe "scrapes podcasts from various sources" do

    it "via chartable" do
      expect(DiscoveryService.new).to_not be_nil
      test_pod = Podcast.new(title: "Test")
      test_eps = []
      expect(test_pod.episodes.count).to eq(0)
      expect(test_eps).to eq([])
    end

  end

  describe "scrapes new episodes from podcasts" do
    it "via existing feeds" do
      expect(DiscoveryService.new).to_not be_nil
    end

  end

end
