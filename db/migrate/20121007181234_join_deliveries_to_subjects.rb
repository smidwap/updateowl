class JoinDeliveriesToSubjects < ActiveRecord::Migration
  def change
    add_column :deliveries, :subject_id, :integer

    deliveries = select_all("SELECT * FROM deliveries;")
    deliveries.each do |delivery|
      subject = select_one("SELECT * FROM subjects WHERE student_id=#{delivery['student_id']} AND message_id=#{delivery['message_id']};")
      execute("UPDATE deliveries SET subject_id=#{subject['id']} WHERE id=#{delivery['id']};")
    end

    remove_column :deliveries, :message_id
    remove_column :deliveries, :student_id
  end
end
