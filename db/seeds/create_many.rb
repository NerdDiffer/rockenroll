module Seeds
  module CreateMany
    class << self
      def rooms
        Defaults.rooms.each { |room| CreateOne.room!(room) }
      end

      def courses
        Defaults.courses.each { |course| CreateOne.course!(course) }
      end

      def people
        Defaults.num_people.times { CreateOne.person! }
      end

      def enrollments
        Defaults.num_enrollments.times do
          student_id = Random.person_id
          teacher_id = Random.person_id
          course_id  = Random.course_id
          CreateOne.enrollment!(student_id, teacher_id, course_id)
        end
      end
    end
  end
end
