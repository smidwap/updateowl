class Student < ActiveRecord::Base
  include ArrayMaker
  include HasManyMessages
  include Nameable

  # TODO: Archive this student upon deletion so that all messages remain intact
  has_many :subjects
  has_many :messages, through: :subjects, order: 'created_at DESC'

  belongs_to :grade_level
  has_one :school, through: :grade_level

  has_many :classroom_relationships, dependent: :destroy
  has_many :users, through: :classroom_relationships
  accepts_nested_attributes_for :classroom_relationships, allow_destroy: true
  
  has_many :family_ties, dependent: :destroy
  has_many :parents, through: :family_ties

  attr_accessible :first_name, :last_name, :classroom_relationships_attributes, :grade_level_id

  scope :not_these, lambda { |students|
    where("students.id NOT IN (?)", students)
  }
  scope :with_registered_parents, lambda {
     joins(:parents)
    .select("students.*, count(students.id) as n_parents")
    .group("students.id")
    .having("n_parents > 0")
  }
  scope :without_registered_parents, lambda {
    not_these(with_registered_parents.all)
  }
  scope :with_parent, lambda { |parents|
     joins(:family_ties)
    .where(family_ties: {parent_id: ids_from(parents)})
  }
  
  after_create :create_pin

  def has_parents?
    parents.count > 0
  end

private

  def create_pin
    self.pin = sprintf('%05d', id * 11 + id)
    self.save!
  end
end