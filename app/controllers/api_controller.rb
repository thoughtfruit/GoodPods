class ApiController < ActionController::Base

  before_action :authenticate

  private
  def client_id ; @_client_id ||= (params[:client_id] || NullClientId) ; end

  def authenticate
    unless client_id.to_s.eql? $CLIENT_ID
      @api = {
        greetings: "🖖 ❤️",
        season: "🍃",
        api_roadmap: "https://www.producthunt.com/@dain/goals/32820",
        unlock: "🔑 to get access to our full API email miller.dain@gmail.com to get a client_id"
      }
      render json: @api, status: 401
    end
  end
end
