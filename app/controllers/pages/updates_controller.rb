class Pages::UpdatesController < ApplicationController
  
  def index
    @updates = Update.most_recent_first
  end
  
end
