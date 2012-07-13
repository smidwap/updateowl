class Student < ActiveRecord::Base
  has_many :messages

  attr_accessible :first_name, :last_name

  def full_name
    "#{try(:first_name)}" + (last_name? ? " #{try(:last_name)}" : "")
  end

  def has_parents?
    true
  end
end