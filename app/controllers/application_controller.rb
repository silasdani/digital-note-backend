class ApplicationController < ActionController::Base
    include Pundit
    skip_before_action :verify_authenticity_token
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def user_not_authorized
     render json: {error: "You are not authorized to perform this action"}, :status => :unauthorized
    end

      # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      render json: { message: "Log in first!" }, status: 322
    end
  end
end
