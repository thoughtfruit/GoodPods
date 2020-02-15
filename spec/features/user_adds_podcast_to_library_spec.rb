require 'rails_helper'

feature "User adds podcast to library" do

  scenario "in to_listen shelf" do
    user = User.create! email: 'djasdoijfasd@dain.io', password: 'ajsdoifjsof'
    podcast = Podcast.create! title: "Test"
    visit "/podcasts/1"
    check "to-listen"
    expect(page.find("input#to-listen")).to be_checked
  end

  scenario "in listening shelf" do
    user = User.create! email: 'djasdoijfasd@dain.io', password: 'ajsdoifjsof'
    podcast = Podcast.create! title: "Test"
    visit "/podcasts/1"
    check "listening"
    expect(page.find("input#listening")).to be_checked
  end

  scenario "in listened status" do
    user = User.create! email: 'djasdoijfasd@dain.io', password: 'ajsdoifjsof'
    podcast = Podcast.create! title: "Test"
    visit "/podcasts/1"
    check "listened"
    expect(page.find("input#listened")).to be_checked
  end

end
