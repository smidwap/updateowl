class Student < ActiveRecord::Base
  include ArrayMaker
  include HasManyMessages

  has_many :student_parents
  has_many :parents, through: :student_parents

  attr_accessible :first_name, :last_name

  scope :with_registered_parents, lambda {
     joins(:student_parents)
    .select("students.*, count(students.id) as n_parents")
    .group("students.id")
    .having("n_parents > 0")
  }
  scope :without_registered_parents, includes(:student_parents).where(student_parents: {id: nil})
  scope :with_parent, lambda { |parents|
     joins(:student_parents)
    .where(student_parents: {parent_id: ids_from(parents)})
  }
  scope :ordered_by_name, order("last_name ASC, first_name ASC")

  def full_name
    "#{try(:first_name)}" + (last_name? ? " #{try(:last_name)}" : "")
  end

  def has_parents?
    parents.count > 0
  end
end