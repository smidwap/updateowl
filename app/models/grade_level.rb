class GradeLevel < ActiveRecord::Base
  belongs_to :school
  has_many :students

  attr_accessible :name
end
