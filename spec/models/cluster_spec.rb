require 'rails_helper'

RSpec.describe Cluster, type: :model do

  context "cluster podcasts for users to easily discover" do

    describe "#.cluster_podcasts_for_user_by_most_listened_to_genre" do
      xit "should return the most popular podcasts in the genre the user has listened to the most" do
      end
    end

    describe "#.cluster_podcasts_by_podcast" do
      xit "should return the most similar podcasts to the passed in podcast_id" do
      end
    end

  end

end