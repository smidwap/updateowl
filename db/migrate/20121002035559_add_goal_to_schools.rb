class AddGoalToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :messages_per_week_goal, :integer, default: 10

    schools = select_all("SELECT * FROM schools;")
    schools.each do |school|
      execute("UPDATE schools SET messages_per_week_goal=10 WHERE id=#{school['id']};")
    end
  end
end
