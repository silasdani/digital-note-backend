class UserController < ApplicationController
    before_action: :authorized_user

    def index
    end

    def create
    end

    def show
    end

    def update
    end

    def destroy
    end
    
end

private 

def authorized_user
    authorize @user
    authorize @users
end