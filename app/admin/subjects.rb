# frozen_string_literal: true

ActiveAdmin.register Subject do
  menu parent: 'Profile options'
  permit_params :title, :category

  index do
    selectable_column
    id_column
    column :title
    column :category
    actions
  end

  filter :title
  filter :category

  form do |f|
    f.inputs do
      f.input :title
      f.input :category
    end
    f.actions
  end

  controller do
    def update
      @subject = Subject.find(params[:id])
      @subject.update(permitted_params[:subject])
      if @subject.errors.blank?
        redirect_to admin_subjects_path, notice: 'Subjects updated successfully.'
      else
        render :edit
      end
    end
  end
end
