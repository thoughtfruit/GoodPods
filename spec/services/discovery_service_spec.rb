require 'rails_helper'

RSpec.describe DiscoveryService, type: :model do

  describe "scrapes podcasts from various sources" do

    it "via chartable" do
      expect(DiscoveryService.test).to be_truthy
    end

  end
end
