class Student < ActiveRecord::Base
  include HasManyMessages
  include Nameable

  has_many :student_messages, order: 'created_at DESC', dependent: :destroy
  has_many :messages, through: :student_messages, order: 'created_at DESC'

  belongs_to :grade_level
  has_one :school, through: :grade_level

  has_many :classroom_relationships, dependent: :destroy
  has_many :users, through: :classroom_relationships
  accepts_nested_attributes_for :classroom_relationships, allow_destroy: true
  
  has_many :family_ties, dependent: :destroy
  has_many :parents, through: :family_ties

  attr_accessible :first_name, :last_name, :classroom_relationships_attributes, :grade_level_id

  scope :not_these, lambda { |students| where("students.id NOT IN (?)", students) }
  scope :with_registered_parents, where('parents_count > 0')
  scope :without_registered_parents, where('parents_count = 0')
  scope :with_parent, lambda { |parents|
     joins(:family_ties)
    .where(family_ties: {parent_id: parents})
  }
  
  after_create :create_pin

  def has_parents?
    parents_count > 0
  end

private

  def create_pin
    self.pin = sprintf('%05d', id * 11 + id)
    self.save!
  end
end