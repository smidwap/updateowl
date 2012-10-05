ActiveAdmin.register Message do
  index do
    column :id, sortable: true
    column :sent, sortable: true do |message|
      message.created_at
    end
    column :teacher do |message|
      message.user.full_name
    end
    column :body
    column :school do |message|
      message.school.name
    end
    column :checked do |message|
      message.checked?
    end

    default_actions
  end
end