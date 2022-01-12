class UsersController < ApplicationController
    # before_action :authorized_user

    def index
        @users = User.all
        render json: UserSerializer.new(@users).serialized_json, status: :ok
    end

    def show
         @user = User.find(params[:id])
        return render json: UserSerializer.new(@user).serialized_json, status: :ok
    end

    def create
        @user = User.new(user_params)
    
        if @user.save
          render json: UserSerializer.new(@user).serialized_json
        else
          render json: { error: @user.errors.messages }, status: :unprocessable_entity
        end
      end
    
      def update
        @user = User.find(params[:id])
        if @user.update(user_params_update)
          render json: UserSerializer.new(@user).serialized_json
        else
          render json: { error: @user.errors.messages }, status: :unprocessable_entity
        end
      end
    
      def destroy
        user = User.find(params[:id])
        if current_user.manager? && user.admin?
          render json: { error: "You cannot delete a admin user!"}, status: 401
        elsif user.destroy
          head :no_content
        else
          render json: { error: user.errors.messages }, status: 422
        end
      end
end

private 

def authorized_user
    # authorize @user
    # authorize @users
end

def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :address_country, :address_street, :address_no, :address_city, :address_county, :password, :password_confirmation)
end