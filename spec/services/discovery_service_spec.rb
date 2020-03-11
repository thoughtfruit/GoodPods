require 'rails_helper'

RSpec.describe DiscoveryService, type: :model do

  describe "scrapes podcasts from various sources" do

    it "via chartable" do
      DiscoveryService.test
    end

  end
end
