class CoursesController < ApplicationController
  include GenericResourcefulActions

  before_action :load_course, only: [:show, :edit, :update, :destroy]

  attr_reader :course
  alias :member_object :course
  decorates_assigned :course

  def index
    @courses = Course.all
  end

  def show
  end

  def new
    @course = Course.new
  end

  def edit
  end

  def create
    @course = Course.new(course_params)
    save_and_respond
  end

  def update
    update_and_respond(course_params)
  end

  def destroy
    course.destroy
    destruction
  end

  private

  def load_course
    id = params[:id]
    @course = Course.find(id)
  end

  def course_params
    params.require(:course).permit(whitelisted_attr)
  end

  def whitelisted_attr
    [:name]
  end
end
