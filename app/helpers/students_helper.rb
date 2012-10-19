module StudentsHelper
  def message_autocomplete_data_for_students(students)
    students.map do |student|
      {
        label: student.full_name,
        value: new_student_message_path(student)
      }
    end
  end

  def global_autocomplete_data_for_students(students)
    students.map do |student|
      {
        label: student.full_name,
        value: student_messages_path(student)
      }
    end
  end

  def extension_autocomplete_data_for_students(students)
    students.map do |student|
      {
        label: student.full_name,
        value: new_student_message_url(student, format: :extension)
      }
    end
  end
end