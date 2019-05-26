class Cluster < ApplicationRecord
  has_many :podcasts

  def web_development_podcasts
    Genre.find_by(title: 'web-development').podcasts
  end

end
