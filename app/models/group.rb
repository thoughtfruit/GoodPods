class Group < ApplicationRecord
  belongs_to :podcast, optional: true
  belongs_to :genre, optional: true
end

# == Schema Information
#
# Table name: groups
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  podcast_id  :integer
#  genre_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
