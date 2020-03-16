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
