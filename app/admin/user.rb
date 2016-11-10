ActiveAdmin.register User do
  menu priority: 1
  permit_params :email, :password, :password_confirmation, :first_name, :last_name, :tickets_nb, :is_coach

  filter :city
  filter :email
  filter :first_name
  filter :last_name
  filter :tickets_nb
  filter :created_at
  filter :is_coach, as: :check_boxes
  filter :admin, as: :check_boxes

  form do |f|
    f.semantic_errors *f.object.errors.keys
    inputs do
      input :email
      input :first_name
      input :last_name
      input :tickets_nb
      input :is_coach
    end
    actions
  end

  index do
    selectable_column
    column :id
    column :email
    column :first_name
    column :last_name
    column :tickets_nb
    column :is_coach
    column :admin
    actions
  end

end
