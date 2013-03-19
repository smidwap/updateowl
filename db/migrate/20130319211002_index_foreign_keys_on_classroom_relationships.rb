class IndexForeignKeysOnClassroomRelationships < ActiveRecord::Migration
  def change
    add_index :classroom_relationships, [:user_id, :student_id]
  end
end
