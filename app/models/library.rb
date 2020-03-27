class Library < UserPodcastStatus
  
  def self.users_listening_to(podcast_id)
    where(
      podcast_id: podcast_id
     ).pluck(&:user_id).compact.count
  end


  def to_listen
    where(
      user: @user,
      status: Status.find('to-listen')
    )
  end

  def listened
    where(
      user: @user,
      status: Status.find('listened')
    )
  end

  def listening
    where(
      user: @user,
      status: Status.find('listening')
    )
  end
end