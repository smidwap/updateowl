class AddCheckedToStudentMessages < ActiveRecord::Migration
  def change
    add_column :student_messages, :checked, :boolean, default: false

    student_messages = select_all("SELECT * FROM student_messages;")
    student_messages.each do |student_message|
      num_checked_deliveries = select_one("SELECT COUNT(id) as count FROM deliveries WHERE student_message_id=#{student_message['id']} AND checked_at IS NOT NULL;")
      if num_checked_deliveries['count'] > 0
        execute("UPDATE student_messages SET checked=TRUE WHERE id=#{student_message['id']};")
      end
    end
  end
end
