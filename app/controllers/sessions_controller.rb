
   
class SessionsController < ApplicationController
    include SessionsHelper

    def create
      user = User.find_by(email: params[:session][:email].downcase)
      token = AuthenticationTokenService.auth(user)
  
      if user && user.authenticate(params[:session][:password])
        render json: {token: token}
      else
        render json: { error: "Invalid email or password"  }, status: :unprocessable_entity 
      end
    end
  
    def destroy
      log_out if logged_in?
      head :no_content
    end
  
    private
  
    def options
      @options ||= { include: %i[locations] }
    end
  
  end