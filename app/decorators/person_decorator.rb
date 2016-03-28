class PersonDecorator < Draper::Decorator
  delegate_all

  def full_name
    first_name + ' ' + last_name
  end

  def first_name_plus_initial
    first_name + ' ' + last_name[0] + '.'
  end
end
