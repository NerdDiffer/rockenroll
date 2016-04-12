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
          begin
            student_id = Random.person_id
            teacher_id = Random.person_id
            course_id  = Random.course_id
            CreateOne.enrollment!(student_id, teacher_id, course_id)
          rescue ActiveRecord::RecordInvalid => e
            puts "#{e}. Retrying"
            retry
          end
        end
      end

      def meetings
        Defaults.num_meetings.times do
          begin
            start  = Random.meeting_start
            length = Random.meeting_length
            associations = { course_id:     Random.course_id,
                             room_id:       Random.room_id,
                             enrollment_id: Random.enrollment_id }
            CreateOne.meeting!(start, length, associations)
          rescue ActiveRecord::RecordInvalid => e
            puts "#{e}. Retrying"
            retry
          end
        end
      end
    end
  end
end
