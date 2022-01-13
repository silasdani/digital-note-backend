class CoursesController < ApplicationController
  after_action :add_role, only: %i[create]
  before_action :logged_in_user
  before_action :set_course, only: %i[show update destroy]
  before_action :authorized_user, only: %i[create update destroy]

  def index
    @courses = Course.all
    authorize current_user
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

  def show
    render json: CourseSerializer.new(@course).serialized_json, status: :ok
  end

  def update
    render json: CourseSerializer.new(@course).serialized_json, status: :ok
  end

  def destroy
    Course.destroy(@course.id)
    head :no_content
  end
end

def course_params
  params.require(:course).permit(:name, :credits, :icon, :max_users)
end

def set_course
  @course = Course.find(params[:id])
end

def add_role
  @user.add_role :moderator, @course
end
