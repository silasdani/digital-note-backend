class CoursesController < ApplicationController
    after_create :add_role, only: %i[create]

    def index
    end

    def create
        @user = current_user
        @course = Course.new(course_params)
        if @course.save
            render json: @course
        else
            render json: {error: "Cannot create a new course"}, status: :unprocessable_entity
        end

    end

    def show
    end

    def update
    end

    def destroy
    end

end

def course_params
    params.require(:course).permit(:name, :credits, :icon, :max_users)
end

def add_role
    @user.add_role :moderator, @post
end
