module Seeds
  module Defaults
    @rooms = %w(alpha beta)
    @courses = ['Intro to foo bars', 'Seminar in basket-weaving',
                'Advanced Q-tipping']
    @people = [{ first_name: 'Albert', last_name: 'Bar' },
               { first_name: 'Blaire', last_name: 'Foo' }]

    class << self
      attr_reader :rooms, :courses, :people
    end
  end
end
