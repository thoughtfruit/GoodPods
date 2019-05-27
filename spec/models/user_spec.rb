require 'rails_helper'

RSpec.describe User, type: :model do

  def build_db
    Podcast.all.each &:destroy
    User.all.each &:destroy

    cluster = Cluster.create
    network = Network.create
    podcast = Podcast.create! network: network, cluster: cluster, title: "Joe Rogan Podcast"
    user    = User.create! email: "d@dain.io", password: "password1"
    return podcast, user
  end

  context "core user features" do

    describe "user podcast status (library)" do 
      it "should allow me to add a podcast to my library" do
        podcast, user = build_db
        record = UserPodcastStatus.create!(
          podcast: podcast,
          user: user,
          status: Status.find('to-listen')
        )

        # expect(record).to be_valid
        expect(record.valid?).to eq(true)
        expect(user.to_listen.count).to eq(1)
      end
    end

    describe "user updates" do
      it "should allow me to add an update about a podcast" do
        podcast, user = build_db

        record = Update.create!(
          user: user,
          podcast: podcast,
          title: "Update title",
          body: "Update body"
        )

        expect(record.valid?).to eq(true)
        expect(user.updates.size).to eq(1)
      end
    end

  end

end
