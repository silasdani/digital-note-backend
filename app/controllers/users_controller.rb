class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:create, :email_taken]

  # GET /users
  # GET /users.json
  def index
    @users = User.with_attached_profile_pic
      .limit(params.fetch(:limit, 20))
      .offset(params.fetch(:offset, 0))

    append_search_params
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.with_attached_profile_pic.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    create_params = user_params

    @user = UsersService.create!({
      user: create_params
    })

    render :show, status: :created, location: user_url(@user, format: :json)
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.with_attached_profile_pic.find(params[:id])
    authorize @user, policy_class: UserPolicy

    if user_params[:password].present?
      @user.update_with_password(user_params)
    else
      @user.update(user_params)
    end

    if @user.errors.any?
      render :show, status: :unprocessable_entity, location: user_url(@user, format: :json)
    else
      render :show, status: :ok, location: user_url(@user, format: :json)
    end
  end

  # GET /users/1/account_state
  # GET /users/1.account_state.json
  def account_state
    @user = User.find(params[:id])
  end

  def email_taken
    if User.exists?(query_params.to_hash)
      head 403
    else
      head 200
    end
  end

  # GET /users?q=thequery&type=EventOperator
  def typeahead
    Raven.capture_message("UsersController#typeahead was hit")

    query = "#{params[:q]}%"
    type = params[:type]
    @users = User.where('first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?',
      query, query, "%" + query)
      .limit(params.fetch(:limit, 10))
    @users = @users.where(type: type) if type
  end

  private
    def append_search_params
      @users = @users.where(type: params[:type]) if params[:type]

      @users = @users.where(type: search_params[:role]) if search_params[:role]

      if search_params[:name]
        name = search_params[:name].split(' ')

        @users = @users.where(
          [
            'lower(first_name) like ? OR lower(last_name) like ?',
            "%#{name[0].downcase}%",
            "%#{name[0].downcase}%",
          ]
        )

        if name[1].present?
          @users = @users.or(@users.where(
            [
              'lower(first_name) like ? OR lower(last_name) like ?',
              "%#{name[1].downcase}%",
              "%#{name[1].downcase}%",
            ]
          ))
        end
      end
    end

    def query_params
      params.permit(:email)
    end

    def search_params
      params.permit(:name, :role)
    end

    def user_params
      convert_file_params [:profile_pic],
        params.fetch(:user).permit(
          # base params
          :current_password,
          :email,
          :password,
          :password_confirmation,
          :type,
          :tc_accepted,
          :hear_about_us,

          # AT base params
          :npi_id,
          :nata_id,
          :nata_expiry,
          :referral_code,

          # profile params
          :first_name,
          :last_name,
          :company_name,
          :phone_no,
          :profile_pic,
          :address_street1,
          :address_street2,
          :address_city,
          :address_state,
          :address_zip,
          :profession_id,
          :finance_email,
          :default_event_setting_id,
          :default_event_profession_id,
        )
    end


end
