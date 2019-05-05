class SearchController < ActionController::Base
  def search
    @podcasts = Podcast.where("title LIKE ?", "#{params[:s]}%")
    render json: @podcasts
  end
end
