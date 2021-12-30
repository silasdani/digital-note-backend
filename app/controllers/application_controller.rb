# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit

  devise_group :user, contains: %i[teacher student]
  def after_sign_in_path_for(resource)
    resource.is_a?(AdminUser) ? admin_dashboard_path : root_path
  end

  def after_sign_out_path_for(_resource_or_scope)
    root_path
  end

  rescue_from Pundit::NotAuthorizedError do |_exception|
    redirect_back fallback_location: root_path, alert: 'You are not allowed to perform this action'
  end

  def authenticate_admin_user!
    raise SecurityError unless current_admin_user.is_a?(AdminUser)
  end

  rescue_from SecurityError do |_exception|
    flash[:danger] = 'You are not allowed to perform this action.'
    redirect_to root_path
  end

  private

  def set_admin_locale
    I18n.locale = :en
  end
end
