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

# == Schema Information
#
# Table name: networks
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
