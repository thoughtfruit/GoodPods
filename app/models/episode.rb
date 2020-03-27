class Episode < ActiveRecord::Base
  include Recording
  
  validates_presence_of :streaming_url
  validates_presence_of :guid

  belongs_to :podcast
  belongs_to :recordable

  after_save {
    if self.podcast.has_no_updates?
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
