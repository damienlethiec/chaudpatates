ActiveAdmin.register City do
	menu priority: 2
	permit_params :name, :user_id, :photo

  filter :name
	filter :user, label: 'COACH', collection: proc { User.where(is_coach: true) }
  filter :trainings
  filter :created_at

  form do |f|
  	f.semantic_errors *f.object.errors.keys
    inputs do
      input :name
      input :user, label: 'Coach', collection: User.where(is_coach: true)
      input :photo, :as => :file
    end
    actions
  end

	index do
    selectable_column
    column :id
    column :name
    column :coach
    column :photo do |event|
      link_to(cl_image_tag event.photo.path, height: 50)
    end
    column :created_at
    actions
  end

end
