ActiveAdmin.register City do
	menu priority: 2
	permit_params :name, :user_id, :photo

  filter :name
	filter :user, label: 'COACH', collection: proc { User.is_coach }
  filter :trainings
  filter :created_at

  controller do
    def scoped_collection
      City.includes({ :trainings => :city })   # specify grandchild model with hash!
    end
  end

  form do |f|
  	f.semantic_errors *f.object.errors.keys
    inputs do
      input :name
      input :user, label: 'Coach', collection: User.is_coach.not_linked_to_city
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
