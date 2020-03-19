class Episode < ActiveRecord::Base
  validates_presence_of :streaming_url
  validates_presence_of :guid

  belongs_to :podcast

  after_save {
    if Update.where(podcast: self.podcast).count == 0
      Update.create!(
        body: "#{self.title}",
        podcast: self.podcast,
        user: User.last
      )
    end
  }

  def who_is_listening?
    if user_signed_in?
      {
        userId: current_user.id,
        userLatestEpisodeId: id
      }
    end
  end
end
