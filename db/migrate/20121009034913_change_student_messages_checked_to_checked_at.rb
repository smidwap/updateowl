class ChangeStudentMessagesCheckedToCheckedAt < ActiveRecord::Migration
  def change
    add_column :student_messages, :checked_at, :datetime

    checked_student_messages = select_all("select * from student_messages where checked = TRUE;")
    checked_student_messages.each do |student_message|
      first_checked_delivery = select_one("select * from deliveries where checked_at IS NOT NULL AND student_message_id = #{student_message['id']} limit 1;")
      if first_checked_delivery
        checked_at = first_checked_delivery['checked_at']
      else
        message = select_one("select * from messages where id=#{student_message['message_id']} limit 1;")
        checked_at = message['created_at']
      end

      execute("update student_messages set checked_at='#{checked_at}' where id=#{student_message['id']};")
    end

    remove_column :student_messages, :checked
  end
end
