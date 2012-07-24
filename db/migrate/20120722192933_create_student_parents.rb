class CreateStudentParents < ActiveRecord::Migration
  def change
    create_table :student_parents do |t|
      t.references :student
      t.references :parent

      t.timestamps
    end
  end
end
