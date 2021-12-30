# frozen_string_literal: true

class TeachersController < ApplicationController
  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save!
      render json: TeacherSerializer.new(@teacher).serialized_json
    else
      render json: { error: 'Cannot create Teacher!' }, status: 422
    end
  end

  def show
    @teacher = Teacher.find(params[:id])
    @reviews = @teacher.teacher_profile.reviews
    @review = Review.new
    @note = @reviews.pluck(:rating).inject { |sum, el| sum + el } / @reviews.size unless @reviews.empty?
    render json: TeacherSerializer.new(@teacher).serialized_json
  end

  def index
    @teachers = Teacher.all
    @teachers = @teachers.where('lower(name) like ?', "#{params[:name].downcase}%") if params[:name].present?
    @teachers = @teachers.joins(:subjects).where(subjects: { title: params[:title] }) if params[:title].present?
    if params[:location].present?
      @teachers = @teachers.joins(:meeting_locations).where(meeting_locations: { name: params[:location] })
    end
    @teachers = @teachers.joins(:study_levels).where(study_levels: { name: params[:level] }) if params[:level].present?
    if params[:exp_years].present?
      @teachers = @teachers.joins(:teacher_profile).where('exp_years >= ?',
                                                          params[:exp_years])
    end
    @teachers = @teachers.joins(:teacher_profile).order(is_promoted: :desc, name: :asc).paginate(page: params[:page],
                                                                                                 per_page: 10)

    @categories = Subject.all.pluck(:category).uniq
    @subjects_by_category = Subject.all.group_by(&:category)
    @titles = {}
    @categories.each do |category|
      @titles[category.to_s] = Subject.all.group_by(&:category)[category].pluck(:title)
    end
    @meeting_locations = MeetingLocation.all.pluck(:name)
    @study_levels = StudyLevel.all.pluck(:name)

    render json: {
      teachers: TeacherSerializer.new(@teachers).serialized_json,
      study_levels: @study_levels,
      meeting_locations: @meeting_locations,
      titles: @titles
    }
  end

  def edit
    @teacher = Teacher.find(params[:id])
    authorize @teacher
    @teacher.create_teacher_profile! unless @teacher.teacher_profile
    @categories = Subject.all.pluck(:category).uniq
    render json: TeacherSerializer.new(@teacher).serialized_json
  end

  def update
    @teacher = Teacher.find(params[:id])
    authorize @teacher
    # update subjects list
    @teacher.subjects.clear
    params[:teacher][:subject_ids].each do |subject_id|
      unless subject_id.empty?
        subject = Subject.find(subject_id)
        @teacher.subjects << subject
      end
    end

    # update study levels
    @teacher.study_levels.clear
    params[:teacher][:study_level_ids].each do |study_level_id|
      unless study_level_id.empty?
        level = StudyLevel.find(study_level_id)
        @teacher.study_levels << level
      end
    end

    # update meeting locations
    @teacher.meeting_locations.clear
    params[:teacher][:meeting_location_ids].each do |meeting_location_id|
      unless meeting_location_id.empty?
        loc = MeetingLocation.find(meeting_location_id)
        @teacher.meeting_locations << loc
      end
    end

    # @teacher.teacher_profile.image.attach(params[:teacher_profile_attributes][:image])

    if @teacher.update(teacher_params)
      flash[:success] = 'Profile updated'
      redirect_to @teacher
      render json: TeacherSerializer.new(@teacher).serialized_json
    else
      render json: { error: 'Forbidden' }, status: 422
    end
  end

  private

  def teacher_params
    params.require(:teacher).permit(:name, :email,
                                    teacher_profile_attributes: %i[education exp_years price meeting_duration_in_minutes desc date_of_birth city image])
  end
end
