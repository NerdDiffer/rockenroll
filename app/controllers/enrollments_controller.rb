class EnrollmentsController < ApplicationController
  include GenericResourcefulActions

  before_action :load_enrollment, only: [:show, :edit, :update, :destroy]

  attr_reader :enrollment
  alias :member_object :enrollment
  decorates_assigned :enrollment

  def index
    @enrollments = Enrollment.all
  end

  def show
  end

  def new
    @enrollment = Enrollment.new
  end

  def edit
  end

  def create
    @enrollment = Enrollment.new(enrollment_params)
    save_and_respond
  end

  def update
    update_and_respond(enrollment_params)
  end

  def destroy
    enrollment.destroy
    destruction
  end

  private

  def load_enrollment
    id = params[:id]
    @enrollment = Enrollment.find(id)
  end

  def enrollment_params
    params.require(:enrollment).permit(whitelisted_attr)
  end

  def whitelisted_attr
    [:course_id, :teacher_id, :student_id]
  end
end
