ActiveAdmin.register User do
  index do
    column :id
    column :first_name
    column :last_name
    column :email

    default_actions
  end

  show do
    attributes_table do
      row :id
      row :first_name
      row :last_name
      row :email
    end
  end

  form do |f|
    f.inputs do
      f.input :school
      f.input :title
      f.input :first_name
      f.input :last_name
      f.input :email
    end

    f.buttons
  end
end
