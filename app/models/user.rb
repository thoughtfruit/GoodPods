class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_uniqueness_of :email
  validates_presence_of :email

  has_many :updates
  has_many :podcasts
  has_many :likes

  def to_s
    full_name
  end
  
  def first_name
    full_name.split(' ').first if full_name
  end
  
  def last_name
    full_name.split(' ').drop(1).join(' ') if full_name
  end
  
  def has_access_to(feature)
    true
  end
  
  def has_completed_episodes?
    statuses.by_type("Episode").completed.any?
  end
  
  def follow
    if user_signed_in?
      current_user.followed << id
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  full_name              :string
#
