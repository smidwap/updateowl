class CreateClassroomRelationships < ActiveRecord::Migration
  def change
    create_table :classroom_relationships do |t|
      t.references :user
      t.references :student
      
      t.timestamps
    end
  end
end
