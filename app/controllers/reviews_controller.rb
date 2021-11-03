class ReviewsController < ApplicationController
  before_action :set_review!, only: [:edit, :update, :destroy]

  def new
    flash[:error] = nil
    @review = Review.new
  end

  def create
    @review = Review.create(review_params)
    @teacher = Teacher.find(params["review"]["teacher_id"])
    if @review.valid?
      redirect_to teacher_path(@teacher)
    else
      flash.now[:error] = "Comment couldn't be created. Please check the errors."
      redirect_to teacher_path(@teacher)
    end
  end

  def edit
    flash[:error] = nil
  end

  def update
    @student = Student.find(@review.user_id)
    @review.update(review_params)
    if @review.valid?
      redirect_to student_path(@student)
    else
      flash[:error] = @review.errors.full_messages
      render :edit
    end
  end

  def destroy
    @student = Student.find(@review.user_id)
    @review.destroy
    redirect_to student_path(@student)
  end

# Private helper methods
  private

  def set_review!
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:user_id, :teacher_profile_id, :rating, :comment)
  end
end