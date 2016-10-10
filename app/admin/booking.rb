ActiveAdmin.register Booking do
	menu priority: 6
	permit_params :user_id, :training_id

	filter :user
	filter :training
  filter :created_at
	
	index do
    selectable_column
    column :id
    column :user
    column :training
    column :created_at
    actions
  end

end
