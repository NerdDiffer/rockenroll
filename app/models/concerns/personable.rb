require 'active_support/concern'

module Personable
  extend ActiveSupport::Concern

  class_methods do
    def collection_for_person(person_id)
      _collection_for_person(person_id) if integer?(person_id)
    end

    private

    def integer?(value)
      value.to_i == value
    end

    def teacher_id_or_student_id_matches(person_id)
      ['teacher_id = ? OR student_id = ?', person_id, person_id]
    end
  end
end
