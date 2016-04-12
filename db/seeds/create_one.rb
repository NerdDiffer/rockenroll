module Seeds
  module CreateOne
    class << self
      def room!(name)
        Room.create!(name: name)
      end

      def course!(name)
        Course.create!(name: name)
      end

      def person!
        min_age = Defaults.person_age[:min]
        max_age = Defaults.person_age[:max]
        Person.create!(first_name: Faker::Name.first_name,
                       last_name:  Faker::Name.last_name,
                       birthdate:  Faker::Date.birthday(min_age, max_age))
      end

      def enrollment!(student_id, teacher_id, course_id)
        Enrollment.create!(student_id: student_id,
                           teacher_id: teacher_id,
                           course_id:  course_id)
      end

      def meeting!(start, length, associations = {})
        Meeting.create!(start:  start,
                        length: length,
                        course_id:     associations[:course_id],
                        room_id:       associations[:room_id],
                        enrollment_id: associations[:enrollment_id])
      end
    end
  end
end
