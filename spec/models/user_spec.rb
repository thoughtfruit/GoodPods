require 'rails_helper'

RSpec.describe User, type: :model do

  context "core user features" do

    describe "user podcast status (library)" do 
      it "should allow me to add a podcast to my library" do
        podcast, user = build_podcast_and_user
        record = UserPodcastStatus.create!(
          podcast: podcast,
          user: user,
          status: Status.find('to-listen')
        )

        # expect(record).to be_valid
        expect(record.valid?).to eq(true)
        expect(Library.find_by(user_id: user.id).to_listen.count).to eq(1)
      end
    end

    describe "user updates" do
      it "should allow me to add an update about a podcast" do
        podcast, user = build_podcast_and_user

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

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  full_name              :string
#
