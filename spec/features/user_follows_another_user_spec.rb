require 'rails_helper'

feature "User follows another user" do 

  xscenario "successfully" do
    visit user_path(user)
    click_on "Follow"
    expect(page).to have_css('.followed', count: 1, text: "Followed")
  end

end
