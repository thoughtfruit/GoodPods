require 'rails_helper'

feature "User follows another user" do 

  scenario "successfully" do
    user = User.create!
    user2 = User.create!
    visit user_path(user)
    click_on "Follow"
    expect(page).to have_css('.followed', count: 1, text: "Followed")
  end

end
