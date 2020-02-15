require 'rails_helper'

RSpec.describe Podcast, type: :model do

  context "side effects" do

    describe "#.after_save" do

      it "should create a Genre object based on the podcast.genre attribute" do
      end

    end

  end

end
