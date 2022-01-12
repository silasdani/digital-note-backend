class CoursesController < ApplicationController
  after_action :add_role, only: %i[create]
  before_action :logged_in_user

  def index
    @courses = Course.all
    render json: CourseSerializer.new(@courses).serialized_json, status: :ok
  end

  def create
    @user = current_user
    @course = @user.courses.new(course_params)

    if @course.save
      render json: CourseSerializer.new(@course).serialized_json, status: :created
    else
      render json: { error: 'Cannot create a new course' }, status: :unprocessable_entity
    end
  end

  def show; end

  def update; end

  def destroy; end
end

def course_params
  params.require(:course).permit(:name, :credits, :icon, :max_users)
end

def add_role
  @user.add_role :moderator, @post
end
