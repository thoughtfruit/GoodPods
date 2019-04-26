class Podcast < ApplicationRecord
  belongs_to :network
  belongs_to :cluster
end
