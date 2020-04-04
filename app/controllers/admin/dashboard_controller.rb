class Admin::DashboardController < ApplicationController
  
  def index
    @user_podcast_statuses = UserPodcastStatus.all
  end
  
end