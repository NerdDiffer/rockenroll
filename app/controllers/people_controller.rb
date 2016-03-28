class PeopleController < ApplicationController
  before_action :load_person, only: [:show, :edit, :update, :destroy]

  attr_reader :person
  decorates_assigned :person

  def index
    @people = People.all
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  def load_person
    id = params[:id]
    @person = Person.find(id)
  end
end
