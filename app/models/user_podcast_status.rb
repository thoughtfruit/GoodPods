class UserPodcastStatus < ActiveRecord::Base
  belongs_to :user
  belongs_to :podcast
end

# == Schema Information
#
# Table name: user_podcast_statuses
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  podcast_id :integer
#  status     :text
#
