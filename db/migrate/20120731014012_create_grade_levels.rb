class CreateGradeLevels < ActiveRecord::Migration
  def change
    create_table :grade_levels do |t|
      t.string :name
      t.references :school

      t.timestamps
    end
  end
end
