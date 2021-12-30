# frozen_string_literal: true

ActiveAdmin.register Student do
  menu priority: 2
  permit_params :name, :email, :password, :password_confirmation, student_profile_attributes: %i[school date_of_birth]

  index do
    selectable_column
    id_column
    column :email
    column :name
    column 'School' do |student|
      student.student_profile.school
    end
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :name
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at
  filter 'student_profile_school', as: :string
  filter 'student_profile_date_of_birth', as: :date_range

  form do |f|
    f.inputs do
      f.input :email
      f.input :name
      f.input :password
      f.input :password_confirmation
    end
    f.fields_for :student_profile do |f|
      f.inputs do
        f.input :school
        f.input :date_of_birth
      end
    end
    f.actions
  end

  controller do
    def update
      @student = Student.find(params[:id])
      StudentPolicy.new(current_admin_user, @student).update?
      unless StudentPolicy.new(current_admin_user, @student).update?
        raise Pundit::NotAuthorizedError, 'You are not authorized to perform this action.'
      end

      if params[:student][:role].present?
        @student.assign_attributes(role: params[:student][:role])
        unless StudentPolicy.new(current_admin_user, @student).update?
          raise Pundit::NotAuthorizedError, 'You are not authorized to perform this action.'
        end
      end
      if params[:student][:password].blank?
        @student.update_without_password(permitted_params[:student])
      else
        @student.update(permitted_params[:student])
      end
      if @student.errors.blank?
        redirect_to admin_students_path, notice: 'Student updated successfully.'
      else
        render :edit
      end
    end
  end
end
