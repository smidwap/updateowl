class AddLastCheckedAtToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :last_checked_at, :datetime

    checked_messages = select_all("select * from messages where checks_count > 0;")
    checked_messages.each do |message|
      last_checked_student_message = select_one("select * from student_messages where message_id=#{message['id']} order by checked_at desc limit 1;")
      execute("update messages set last_checked_at='#{last_checked_student_message['checked_at']}' where id=#{message['id']};")
    end
  end
end
