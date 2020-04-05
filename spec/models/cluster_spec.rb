require 'rails_helper'

RSpec.describe Cluster, type: :model do

  context "cluster podcasts for users to easily discover" do
    it "should return the most similar podcasts to the passed in podcast_id" do
      expect(true).to be_truthy
    end
  end

end

# == Schema Information
#
# Table name: clusters
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
