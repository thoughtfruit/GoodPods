class Network < ApplicationRecord
  DEFAULTS = ['relayfm',
              'twit',
              'gimlet',
              'wondery',
              '5by5',
              'the incomperable',
              'startherefm',
            ]

  has_many :podcasts

  def self.search_by_title reference_title
    # TODO refactor to helper E.g. search_by_title
    where("title like ?", "%#{reference_title}%").try(:uniq)
  end
end
