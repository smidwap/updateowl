class UserStatsCompiler
  @queue = :user_stats_compiler

  def self.perform
    User.all.each do |user|
      Analytics.with_current_user(user) do
        num_students = user.students.length

        if num_students > 0
          num_registered = user.students.with_registered_parents.length
          percentage = num_registered.to_f / num_students.to_f

          Analytics.set_people_properties({
            "Students" => num_students,
            "Students with Registered Parents" => num_registered,
            "Percentage Students with Registered Parents" => percentage
          })
        end
      end
    end
  end
end