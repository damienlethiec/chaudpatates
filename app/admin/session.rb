ActiveAdmin.register Session do
	menu priority: 4
	permit_params :day, :time_of_day, :city_id

	filter :city
  filter :day, as: :select
  filter :created_at

	index do
    selectable_column
    column :id
    column :day
    column :time_of_day do |r|
    	r.time_of_day.strftime('%H:%M')
  	end
    column :created_at
    actions
  end


end
