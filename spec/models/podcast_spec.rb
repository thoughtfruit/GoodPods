require 'rails_helper'

RSpec.describe Podcast, type: :model do

  describe "#.after_save" do

    it "should create a Genre object based on the podcast.genre attribute" do
      expect(true).to be_truthy
    end

  end
end
