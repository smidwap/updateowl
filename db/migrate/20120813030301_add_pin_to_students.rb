class AddPinToStudents < ActiveRecord::Migration
  def change
    add_column :students, :pin, :string
  end
end
