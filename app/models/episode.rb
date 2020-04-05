class Episode < ActiveRecord::Base

  validates_presence_of :streaming_url
  validates_presence_of :guid

  belongs_to :podcast

  after_save {
    create_automated_episode_update if self.podcast.has_no_updates?
  }
  
  def to_s
    title
  end

  def who_is_listening?
    {
      userId: current_user.id,
      userLatestEpisodeId: id
    } if user_signed_in?
  end

  def able_to_log_new_episode?
    if self.podcast.updates.find_by(body: "#{self.title}").nil?
      return true
    else
      return false
    end
  end

  def create_automated_episode_update
    Update.create!(
      body: "#{self.title}",
      podcast: self.podcast,
      user: User.last
    )
  end

end

# == Schema Information
#
# Table name: episodes
#
#  id             :integer          not null, primary key
#  episode        :string
#  podcast_id     :integer
#  title          :string
#  description    :text
#  published      :boolean
#  episode_number :string
#  streaming_url  :text
#  published_at   :date
#  tags           :text
#  tier_required  :integer
#  guid           :text
#
