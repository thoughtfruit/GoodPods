class Genre < ApplicationRecord
  belongs_to :user
  belongs_to :podcast
  has_many :groups
end
