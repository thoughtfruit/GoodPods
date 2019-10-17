class NullUser

  def initialize
    User.last
  end

end
