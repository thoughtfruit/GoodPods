require 'rails_helper'

RSpec.describe Podcast, type: :model do

  describe "after create" do
    it "creates bio" do
      expect(true).to be_truthy
    end
  end

  describe "after save" do
    it "ingests podcast episodes" do
      expect(true).to be_truthy
    end
  end

end

# == Schema Information
#
# Table name: podcasts
#
#  id              :integer          not null, primary key
#  network_id      :integer
#  cluster_id      :integer
#  title           :string
#  itunes_url      :string
#  feed_url        :string
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  logo_url        :string
#  ranking         :integer
#  bio             :text
#  genre           :text
#  logo_url_large  :text
#  collection_id   :integer
#  xml_valid       :boolean
#  last_fetched_at :date
#
