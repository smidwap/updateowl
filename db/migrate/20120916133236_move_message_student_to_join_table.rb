class MoveMessageStudentToJoinTable < ActiveRecord::Migration
  def up
    #
    # Migrate message students over to join table
    #
    create_table :messages_students do |t|
      t.references :message
      t.references :student
    end

    add_index :messages_students, [:message_id, :student_id]
    add_index :messages_students, [:student_id, :message_id]

    # We'll now need a student_id field in the deliveries table
    add_column :deliveries, :student_id, :integer

    messages = select_all("SELECT * FROM messages;")
    messages.each do |message|
      if message['student_id'].present?
        execute("INSERT INTO messages_students SET message_id='#{message['id']}', student_id='#{message['student_id']}';")
      end

      # Associate each delivery with a student
      deliveries = select_all("SELECT * FROM deliveries WHERE message_id='#{message['id']}';")
      deliveries.each do |delivery|
        if delivery['message_id']. present?
          execute("UPDATE deliveries SET student_id='#{message['student_id']}' WHERE message_id='#{message['id']}';")
        end
      end
    end

    #
    # Perform a little cleanup on the deliveries table, getting rid of records with NULL student id's
    #
    deliveries = select_all("SELECT * FROM deliveries;")
    deliveries.each do |delivery|
      if delivery['student_id'].nil?
        execute("DELETE FROM deliveries WHERE id='#{delivery['id']}';")
      end
    end

    #
    # Get rid of student_id in messages table
    #
    remove_column :messages, :student_id
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
