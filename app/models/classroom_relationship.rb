class ClassroomRelationship < ActiveRecord::Base
  belongs_to :user
  belongs_to :student

  attr_accessible :student_id, :user_id
end
