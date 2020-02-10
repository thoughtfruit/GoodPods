require 'rails_helper'

RSpec.describe Podcast, type: :model do

  context "side effects" do

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
