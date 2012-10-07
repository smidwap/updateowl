class RenameStudentsMessagesToSubjects < ActiveRecord::Migration
  def change
    rename_table :messages_students, :subjects
  end
end
