ActiveAdmin.register Session do
	menu priority: 4
	permit_params :day, :time_of_day, :city_id

	filter :city
  filter :day, as: :select
  filter :created_at

  controller do
    def scoped_collection
      Session.includes(:city)   # specify grandchild model with hash!
    end
  end

  show do
    attributes_table do
      row :id
      row :city
      row :day
      row :time_of_day do |r|
        r.time_of_day.strftime('%H:%M')
      end
      row :created_at
      row :updated_at
    end
  end

	index do
    selectable_column
    column :id
    column :city
    column :day
    column :time_of_day do |r|
    	r.time_of_day.strftime('%H:%M')
  	end
    column :created_at
    actions
  end
end
