class Pages::HomepageController < ApplicationController
  before_action :authenticate

  def homepage
  end

  def authenticate
    unless current_user
      redirect_to '/users/sign_in'
    end
  end
end
