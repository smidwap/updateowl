class AddCounterCachesToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :checks_count, :integer
    add_column :messages, :student_messages_count, :integer

    messages = select_all('SELECT * FROM messages;')
    messages.each do |message|
      student_messages = select_all("SELECT * FROM student_messages WHERE message_id=#{message['id']};")
      checks_count = student_messages.select { |result| result['checked'] == 1 }.count
      student_messages_count = student_messages.count
      execute("UPDATE messages SET checks_count=#{checks_count}, student_messages_count=#{student_messages_count} WHERE id=#{message['id']};")
    end
  end
end
