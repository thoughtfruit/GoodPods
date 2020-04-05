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

# == Schema Information
#
# Table name: updates
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  title      :string
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  podcast_id :integer
#
