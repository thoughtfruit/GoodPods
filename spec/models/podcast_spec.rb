require 'rails_helper'

RSpec.describe Podcast, type: :model do

  context "search" do
    describe "#.search_by_title" do
      it "return the first podcast with a similar title" do
        podcast, user = build_podcast_and_user
        p1 = Podcast.search_by_title "no podcasts with this title"
        expect(p1).to be_nil
        p2 = Podcast.search_by_title "Joe"
        expect(p2.title).to eq("Joe Rogan Podcast")
        expect(p2.valid?).to eq(true)
      end
    end
  end

  context "explode genre's to their own model object after saving" do
    describe "#.after_save" do
      it "should create a Genre object based on the podcast.genre attribute" do
        # after_save {
        #   Genre.create!(
        #     title: self.genre,
        #     podcast_id: self.id,
        #     user_id: current_user.id
        #   )
        # }
      end
    end
  end

end
