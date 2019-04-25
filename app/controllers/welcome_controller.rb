class WelcomeController < ApiController
  respond_to :json

  def welcome
    welcome_message = {
      greetings: "🖖 ❤️",
      season: "🍃",
      api_roadmap: "https://www.producthunt.com/@dain/goals/32820"
    }
    render json: welcome_message, status: 200
  end

end
