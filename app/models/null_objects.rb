class NullPodcast
  def initialize podcast:
    true
  end
end

class NullUser
  def initialize
    User.last
  end
end