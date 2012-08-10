class AddSchoolToParents < ActiveRecord::Migration
  def change
    add_column :parents, :school_id, :integer
  end
end
