class ApplicationController < ActionController::Base
    include Pundit
    protect_from_forgery

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def user_not_authorized
     render json: {error: "You are not authorized to perform this action"}, :status => :unauthorized
    end

end
