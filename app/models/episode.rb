class Episode < ActiveRecord::Base
  validates_presence_of :streaming_url
  validates_presence_of :guid

  belongs_to :podcast

  def who_is_listening?
    if user_signed_in?
      {
        userId: current_user.id,
        userLatestEpisodeId: id
      }
    end
  end
end
