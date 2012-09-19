class UserStatsCompiler
  @queue = :user_stats_compiler

  def self.perform
    User.all.each do |user|
      Analytics.with_current_user(user) do
        num_students = user.students.length

        if num_students > 0
          num_registered = user.students.with_registered_parents.length
          percentage = num_registered.to_f / num_students.to_f
          last_update_sent = user.messages.count > 0 ? user.messages.last.created_at : nil

          Analytics.set_people_properties({
            "$first_name" => user.first_name,
            "$last_name" => user.last_name,
            "$email" => user.email,
            "$created" => user.created_at,
            "School" => user.school.name,
            "Students" => num_students,
            "Students with Registered Parents" => num_registered,
            "Percentage Students with Registered Parents" => percentage,
            "Updates Unchecked" => user.messages.unchecked.count,
            "Updates Last Week" => user.messages.last_week.count,
            "Updates Sent" => user.messages.count,
            "Last Update Sent" => last_update_sent
          })
        end
      end
    end
  end
end