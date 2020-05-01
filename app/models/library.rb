class Library < UserPodcastStatus
  def initialize user
    @user = user
  end

  def self.users_listening_to(podcast_id)
    where(
      podcast_id: podcast_id
     ).pluck(&:user_id).compact.count
  end

  def to_listen
    UserPodcastStatus.where(
      user: @user,
      status: Status.find('to-listen')
    )
  end

  def listened
    UserPodcastStatus.where(
      user: @user,
      status: Status.find('listened')
    )
  end

  def listening
    UserPodcastStatus.where(
      user: @user,
      status: Status.find('listening')
    )
  end

end
