class UsersController < ApplicationController
  def index
    render json: User.all
  end

  def show
  end

  def create
  end

  def destroy
  end
end
