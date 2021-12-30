# frozen_string_literal: true

ActiveAdmin.register MeetingLocation do
  menu parent: 'Profile options'
  permit_params :name

  index do
    selectable_column
    id_column
    column :name
    actions
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
    end
    f.actions
  end

  controller do
    def update
      @loc = MeetingLocation.find(params[:id])
      @loc.update(permitted_params[:subject])
      if @loc.errors.blank?
        redirect_to admin_meeting_locations_path, notice: 'Meeting locations updated successfully.'
      else
        render :edit
      end
    end
  end
end
