require 'rails_helper'

feature "User searches for podcasts" do

  scenario "by genre" do
    podcast = Podcast.create!(title: "Comedy Podcast", genre: "Comedy", logo_url: 'test')
    podcast = Podcast.create!(title: "Other Podcast", genre: "Other", logo_url: 'test')
    visit discover_index_path
    fill_in 'search', with: 'Comedy'
    expect(page).to have_css('div#1')
  end

  scenario "by title" do
    podcast = Podcast.create!(title: "Podcast title", genre: "Comedy", logo_url: 'test')
    visit discover_index_path
    fill_in 'search', with: 'title'
    expect(page).to have_css('div#1')
  end

  scenario "by network or collection" do
    collection = Collection.create!(title: "relayfm")
    podcast = Podcast.create!(title: "Podcast title", genre: "Comedy", logo_url: 'test', collection: collection)
    visit discover_index_path
    fill_in 'search', with: 'relayfm'
    expect(page).to have_css('div#1')
  end
end
