class WelcomeController < ApiController

  def welcome
    @welcome = OpenStruct.new(message: "You made it past the guards! 💂")
    render json: @welcome, status: 200
  end

end
