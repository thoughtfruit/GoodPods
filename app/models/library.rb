class Library < UserPodcastStatus

  def self.users_listening_to(podcast_id)
    where(
      podcast_id: podcast_id
     ).pluck(&:user_id).compact.count
  end

  def to_listen
    UserPodcastStatus.where(
      user: self,
      status: Status.find('to-listen')
    )
  end

  def listened
    UserPodcastStatus.where(
      user: self,
      status: Status.find('listened')
    )
  end

  def listening
    UserPodcastStatus.where(
      user: self,
      status: Status.find('listening')
    )
  end

end
