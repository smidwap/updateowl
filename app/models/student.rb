class Student < ActiveRecord::Base  
  include HasManyMessages

  attr_accessible :first_name, :last_name

  scope :ordered_by_name, order("last_name ASC, first_name ASC")

  def full_name
    "#{try(:first_name)}" + (last_name? ? " #{try(:last_name)}" : "")
  end

  def has_parents?
    true
  end
end