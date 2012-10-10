class AddDefaultsToCaches < ActiveRecord::Migration
  def change
    change_column :messages, :checks_count, :integer, default: 0
    change_column :messages, :student_messages_count, :integer, default: 0
  end
end
