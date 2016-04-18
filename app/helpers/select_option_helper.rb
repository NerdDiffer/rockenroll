module SelectOptionHelper
  class << self

    def all_rooms
      rooms = fetch_all_rooms
      rooms.each_with_object({}) do |(room), rooms_collection|
        collect(room, rooms_collection)
      end
    end

    def all_courses
      courses = fetch_all_courses
      courses.each_with_object({}) do |(course), collection|
        collect(course, collection)
      end
    end

    def all_people
      people = fetch_all_people
      people.each_with_object({}) do |(person), collection|
        collect_people(person, collection)
      end
    end

    private

    def fetch_all_rooms
      Room.all
    end

    def fetch_all_courses
      Course.all
    end

    def fetch_all_people
      Person.all
    end

    def collect(member, collection)
      name = member.name.to_s
      id   = member.id
      collection[name] = id
      collection
    end

    def collect_people(person, collection)
      person = person.decorate

      name = person.first_name_plus_initial.to_s
      id   = person.id
      collection[name] = id
      collection
    end
  end
end
