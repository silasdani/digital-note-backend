# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  include SessionsHelper
  skip_before_action :verify_authenticity_token
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    render json: { error: 'You are not authorized to perform this action' }, status: :unauthorized
  end

  # Confirms a logged-in user.
  def logged_in_user
    render json: { error: 'You are not logged in' } unless logged_in?
  end
end
