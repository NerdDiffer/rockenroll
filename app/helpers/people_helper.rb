module PeopleHelper
  # TODO: Use draper instead of helper after you've got the MVP going
  def full_name(person)
    person.first_name + ' ' + person.last_name
  end

  def first_name_plus_initial(person)
    person.first_name + ' ' + person.last_name[0] + '.'
  end
end
