ActiveAdmin.register TicketsPackage do
	menu priority: 7
	permit_params :user_id, :training_id
  actions :index, :show, :edit, :update

  config.filters = false

  index do
    column :sku
    column :price
    column :tickets_nb
    actions
  end

  show do
    attributes_table do
      row :id
      row :sku
      row :price
      row :tickets_nb
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    inputs do
      input :sku
      input :price
      input :tickets_nb
    end
    actions
  end

end