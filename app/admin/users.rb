ActiveAdmin.register User do
  index do
    column :id
    column :first_name
    column :last_name
    column :email

    default_actions
  end

  show do
    students_with_registered_parents = user.students.with_registered_parents.all
    students_with_no_updates = students_with_registered_parents.select { |student| student.messages.individual.length == 0 }
    attributes_table do
      row :id
      row :first_name
      row :last_name
      row :email
      row "number of students with registered parents" do |user|
        students_with_registered_parents.length
      end
      row "number of students without updates" do |user|
        students_with_no_updates.length
      end
      row "percentage" do |user|
        (students_with_no_updates.length.to_f / students_with_registered_parents.length * 100).round if students_with_registered_parents.length > 0
      end
      row "students without updates" do |user|
        students_with_no_updates.sort_by(&:last_name).map(&:full_name).join("<br>").html_safe
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :school
      f.input :title, as: :select, collection: User::TITLES
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end

    f.buttons
  end
end
