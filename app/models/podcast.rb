class Podcast < ApplicationRecord
  belongs_to :network
  belongs_to :cluster
  has_many :genres

  validates :title, uniqueness: true, on: [:update, :create]
end
