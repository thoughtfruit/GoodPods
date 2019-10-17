require 'rails_helper'

RSpec.describe Api::V1::MyLibraryController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe "GET all_library" do
    it "renders all podcasts for all statuses for current_user" do
      user = User.find_by(email: 'd@dain.io')
      podcast = Podcast.create!(title: '')
      get :all_library, params: { user_id: user.id }
      expect(JSON.parse(response.body)).to eq([{"id"=>3, "podcast_id"=>4, "status"=>"to-listen", "user_id"=>3}])
    end
  end

  describe "GET status_for_podcast_and_user" do
    it "renders the current_user's statuses" do
      user = User.find_by(email: 'd@dain.io')
      podcast = Podcast.create!(title: '')
      UserPodcastStatus.create!(user: user, podcast: podcast, status: 'to-listen')
      get :status_for_podcast_and_user, params: { podcast_id: podcast.id, user_id: user.id }
      expect(response.body).to eq('["to-listen"]')
    end
  end

end
