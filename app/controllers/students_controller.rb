class StudentsController < ApplicationController
    def show
      @student = Student.find(params[:id])
      @student_profile = @student.student_profile
    end

    def index
      @students = Student.paginate(page: params[:page])
    end
end
