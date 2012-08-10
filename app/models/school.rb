class School < ActiveRecord::Base
  has_many :grade_levels
  has_many :users
  has_many :parents

  attr_accessible :name
end
