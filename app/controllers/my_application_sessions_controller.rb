class SessionsController < DeviseTokenAuth::SessionsController
  before_action :skip_cookies
  before_action :authenticate_user!, except: [:create]
  before_action :format_email, only: [:create]

  def render_create_success
    @user = @resource
      .class
      .with_fat_login_response
      .where('users.id = ?', @resource.id)
      .first
    end

    render 'users/login_response'
  end

  def render_destroy_success
  end

  def format_email
    params[:email] = params[:email].downcase.strip
  end

  private

  def skip_cookies
    request.session_options[:skip] = true
  end
end
