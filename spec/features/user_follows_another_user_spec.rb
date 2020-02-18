require 'rails_helper'

feature "User follows another user" do 

  xscenario "successfully" do
    user = User.create!(email: 'djasdoijfasd@dain.io', password: 'ajsdoifjsof')
    user = User.create!(email: 'aoisdjfaoisjf@aosdijfo.io', password: "u2u38rj38j")
    visit profile_path(user)
    click_on "Follow"
    expect(page).to have_css('followed', count: 1, text: "Followed")
  end

end
