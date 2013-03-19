class IndexForeignKeysOnFamilyTies < ActiveRecord::Migration
  def change
    add_index :family_ties, [:parent_id, :student_id], unique: true
  end
end
