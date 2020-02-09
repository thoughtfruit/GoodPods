class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :updates
  has_many :podcasts
  has_many :likes

  # TODO: Add followed column
  def follow
    if user_signed_in?
      current_user.followed << id
    end
  end

end
