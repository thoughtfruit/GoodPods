class Network < ApplicationRecord
  include Searchable
    
  DEFAULTS = ['relayfm',
              'twit',
              'gimlet',
              'wondery',
              '5by5',
              'the incomperable',
              'startherefm',
            ]

  has_many :podcasts
end
