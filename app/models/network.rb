class Network < ApplicationRecord
  include Search  
    
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
