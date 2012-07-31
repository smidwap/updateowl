class Student < ActiveRecord::Base
  include ArrayMaker
  include HasManyMessages

  belongs_to :grade_level

  has_many :classroom_relationships
  has_many :users, through: :classroom_relationships
  accepts_nested_attributes_for :classroom_relationships
  
  has_many :family_ties
  has_many :parents, through: :family_ties

  attr_accessible :first_name, :last_name, :classroom_relationships_attributes, :grade_level_id

  scope :with_registered_parents, lambda {
     joins(:family_ties)
    .select("students.*, count(students.id) as n_parents")
    .group("students.id")
    .having("n_parents > 0")
  }
  scope :without_registered_parents, includes(:family_ties).where(family_ties: {id: nil})
  scope :with_parent, lambda { |parents|
     joins(:family_ties)
    .where(family_ties: {parent_id: ids_from(parents)})
  }
  scope :ordered_by_name, order("last_name ASC, first_name ASC")

  def full_name
    "#{try(:first_name)}" + (last_name? ? " #{try(:last_name)}" : "")
  end

  def has_parents?
    parents.count > 0
  end
end