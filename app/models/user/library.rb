class User::Library < UserPodcastStatus
  
  def initialize user
    @user = user
  end
  
  def self.users_listening_to podcast_id
    where(
      podcast_id: podcast_id
     ).pluck(&:user_id).compact.count
  end

  def to_listen
    User::Library.where(
      user: @user,
      status: User::Status.find('to-listen')
    )
  end

  def listened
    User::Library.where(
      user: @user,
      status: User::Status.find('listened')
    )
  end

  def listening
    User::Library.where(
      user: @user,
      status: User::Status.find('listening')
    )
  end
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
