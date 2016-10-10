ActiveAdmin.register Training do
	menu priority: 5
	permit_params :public_description, :private_description, :city_id, :location_id, :date
  actions :all, except: [:new, :create]

  filter :city
  filter :location
  filter :public_description
  filter :private_description
  filter :date
  filter :created_at

	index do
    selectable_column
    column :id
    column :date
    column :location
    column :public_description
    column :private_description
    column :created_at
    actions
  end

end
