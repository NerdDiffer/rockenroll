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
        Defaults.people.each do |person|
          CreateOne.person!(person[:first_name], person[:last_name])
        end
      end
    end
  end
end
