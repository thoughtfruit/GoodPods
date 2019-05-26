class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :updates
  has_many :podcasts
  has_many :likes

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
