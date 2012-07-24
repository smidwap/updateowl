class CreateParents < ActiveRecord::Migration
  def change
    create_table :parents do |t|
      t.string :phone
      t.string :email
      t.string :preference
      
      t.timestamps
    end
  end
end
