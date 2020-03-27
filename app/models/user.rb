class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_uniqueness_of :email
  validates_presence_of :email

  has_many :updates
  has_many :podcasts
  has_many :likes

  def follow
    if user_signed_in?
      current_user.followed << id
    end
  end
end
