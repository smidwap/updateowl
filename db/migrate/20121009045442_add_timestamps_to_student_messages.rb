class AddTimestampsToStudentMessages < ActiveRecord::Migration
  def change
    add_column :student_messages, :created_at, :datetime
    add_column :student_messages, :updated_at, :datetime

    student_messages = select_all("select * from student_messages;")
    student_messages.each do |student_message|
      message = select_one("select * from messages where id=#{student_message['message_id']};")
      execute("update student_messages set created_at='#{message['created_at']}', updated_at='#{message['updated_at']}' where id=#{student_message['id']};")
    end
  end
end
