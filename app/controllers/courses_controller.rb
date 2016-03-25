class CoursesController < ApplicationController
  before_action :load_course, only: [:show, :edit, :update, :destroy]

  attr_reader :course

  def index
    @courses = Course.all
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

  def load_course
    id = params[:id]
    @course = Course.find(id)
  end
end
