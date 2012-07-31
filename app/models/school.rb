class School < ActiveRecord::Base
  has_many :grade_levels
  has_many :users

  attr_accessible :name
end
