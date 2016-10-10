ActiveAdmin.register City do
	menu priority: 2
	permit_params :name, :user_id

  filter :name
	filter :user, label: 'COACH', collection: proc { User.where(is_coach: true) }
  filter :trainings
  filter :created_at

  form do |f|
  	f.semantic_errors *f.object.errors.keys
    inputs do
      input :name
      input :user, label: 'City coach', collection: User.where(is_coach: true)
    end
    actions
  end

	index do
    selectable_column
    column :id
    column :name
    column :coach
    column :created_at
    actions
  end

end
