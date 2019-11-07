class Update < ApplicationRecord
  belongs_to :user
  belongs_to :podcast, optional: true
  has_many :likes

  def email
    user.email
  end

  def self.most_recent_first
    order("created_at desc").all
  end

end
