ActiveAdmin.register GradeLevel do
  index do
    column :id, sortable: true
    column :name, sortable: true
    column :school do |grade_level|
      grade_level.school.name
    end
    default_actions
  end
end
