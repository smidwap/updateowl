class RenameSubjectsToStudentMessages < ActiveRecord::Migration
  def change
    rename_table :subjects, :student_messages
    rename_column :deliveries, :subject_id, :student_message_id
  end
end
