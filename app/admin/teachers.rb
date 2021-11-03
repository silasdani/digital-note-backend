ActiveAdmin.register Teacher do
  menu priority: 3
  permit_params :name, :email, :password, :password_confirmation, teacher_profile_attributes: [:education, :exp_years, :price, :meeting_duration_in_minutes, :desc, :date_of_birth, :city, :is_promoted]

  index do
    selectable_column
    id_column
    column :email
    column :name
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column "Is promoted"  do |teacher|
      teacher.teacher_profile.is_promoted
    end
    actions
  end

  filter :email
  filter :name
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at
  filter "teacher_profile_education", :as => :string
  filter "teacher_profile_exp_years", :as => :numeric
  filter "teacher_profile_price", :as => :numeric
  filter "teacher_profile_meeting_duration_in_minutes", :as => :numeric
  filter "teacher_profile_desc", :as => :string
  filter "teacher_profile_date_of_birth", :as => :date_range
  filter "teacher_profile_city", :as => :string
  filter "teacher_profile_is_promoted", :as => :check_boxes

  form do |f|
    f.inputs do
      f.input :email
      f.input :name
      f.input :password
      f.input :password_confirmation
    end
    f.fields_for :teacher_profile do |f|
      f.inputs do
        f.input :education
        f.input :exp_years
        f.input :price
        f.input :meeting_duration_in_minutes
        f.input :desc
        f.input :date_of_birth
        f.input :city
        f.input :is_promoted
        end
      end
    f.actions
  end

  controller do
    def update
      @teacher = Teacher.find(params[:id])
      TeacherPolicy.new(current_admin_user, @teacher).update?
      unless TeacherPolicy.new(current_admin_user, @teacher).update?
        raise Pundit::NotAuthorizedError, "You are not authorized to perform this action."
      end
      if params[:teacher][:role].present?
        @teacher.assign_attributes(role: params[:teacher][:role])
        unless TeacherPolicy.new(current_admin_user, @teacher).update?
          raise Pundit::NotAuthorizedError, "You are not authorized to perform this action."
        end
      end
      if params[:teacher][:password].blank?
        @teacher.update_without_password(permitted_params[:teacher])
      else
        @teacher.update(permitted_params[:teacher])
      end
      if @teacher.errors.blank?
        redirect_to admin_teachers_path, :notice => "Teacher updated successfully."
      else
        render :edit
      end
    end
  end

end
