class User::History < ActiveRecord::Base
  has_many :episodes
  
  def initialize
  end
  
  def listened
  end
end