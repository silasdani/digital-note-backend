class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      token = AuthenticationTokenService.auth(user)
      log_in user
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unprocessable_entity
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
