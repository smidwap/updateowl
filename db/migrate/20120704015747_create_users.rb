class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.references :school
      t.string :first_name
      t.string :last_name
      t.string :title
      
      t.timestamps
    end
  end
end
