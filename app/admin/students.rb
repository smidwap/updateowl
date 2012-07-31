ActiveAdmin.register Student do
  show do |student|
    attributes_table do
      row :first_name
      row :last_name
      row :grade_level
    end

    panel "Teachers" do
      table_for student.users do
        column "Email" do |user|
          user.email
        end
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :grade_level, collection: GradeLevel.all.map { |gl| [gl.name + " - " + gl.school.name, gl.id] }

      f.has_many :classroom_relationships do |classroom_relationship|
        if !classroom_relationship.object.nil?
          classroom_relationship.input :_destroy, :as => :boolean, :label => "Remove this teacher's access?"
        end
        classroom_relationship.input :user, collection: User.all.map { |u| [u.email, u.id] }
      end
    end

    f.buttons
  end
end
