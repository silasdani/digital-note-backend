ActiveAdmin.register StudyLevel do
  menu :parent => "Profile options"
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
      @level = StudyLevel.find(params[:id])
      @level.update(permitted_params[:subject])
      if @level.errors.blank?
        redirect_to admin_subjects_path, :notice => "Study levels updated successfully."
      else
        render :edit
      end
    end
  end
end