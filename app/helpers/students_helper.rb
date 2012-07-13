module StudentsHelper
  def autocomplete_data_for_students(students)
    students.map { |student|
      {
        label: student.full_name,
        url: new_student_message_path(student)
      }
    }
  end
end