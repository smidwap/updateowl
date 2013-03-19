class AddParentsCountToStudents < ActiveRecord::Migration
  class Student < ActiveRecord::Base
    has_many :family_ties
    has_many :parents, through: :family_ties
  end

  class Parent < ActiveRecord::Base
    has_many :family_ties
    has_many :students, through: :family_ties
  end

  class FamilyTie < ActiveRecord::Base
    belongs_to :student
    belongs_to :parent
  end

  def change
    add_column :students, :parents_count, :integer, default: 0

    Student.reset_column_information
    Student.all.each do |student|
      Student.update_counters(student.id, parents_count: student.parents.count)
    end
  end
end
