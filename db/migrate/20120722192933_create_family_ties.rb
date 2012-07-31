class CreateFamilyTies < ActiveRecord::Migration
  def change
    create_table :family_ties do |t|
      t.references :student
      t.references :parent

      t.timestamps
    end
  end
end
