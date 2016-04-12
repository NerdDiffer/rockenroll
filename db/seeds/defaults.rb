module Seeds
  module Defaults
    @rooms   = %w(Asencio Brouwer Coste Dyens Eythorsson Frasca Giuliani)
    @courses = ['Scales', 'RH technique', 'Ear Training', 'Ensemble']
    @num_people      = 10
    @num_meetings    = 10
    @num_enrollments = 10
    @person_age = { min: 5, max: 100 }

    class << self
      attr_reader :rooms, :courses, :person_age,
                  :num_people, :num_meetings, :num_enrollments
    end
  end
end
