class PeopleController < ApplicationController
  include GenericResourcefulActions

  before_action :load_person, only: [:show, :edit, :update, :destroy]

  attr_reader :person
  alias :member_object :person
  decorates_assigned :person

  def index
    @people = Person.all
  end

  def show
  end

  def new
    @person = Person.new
  end

  def edit
  end

  def create
    @person = Person.new(person_params)
    save_and_respond
  end

  def update
    update_and_respond(person_params)
  end

  def destroy
    person.destroy
    destruction
  end

  private

  def load_person
    id = params[:id]
    @person = Person.find(id)
  end

  def person_params
    params.require(:person).permit(whitelisted_attr)
  end

  def whitelisted_attr
    [:first_name, :last_name, :birthdate]
  end
end
