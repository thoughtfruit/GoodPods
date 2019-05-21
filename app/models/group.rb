class Group < ApplicationRecord
  belongs_to :podcast, optional: true
  belongs_to :genre, optional: true
end
