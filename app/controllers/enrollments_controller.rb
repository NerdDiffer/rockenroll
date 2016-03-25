class EnrollmentsController < ApplicationController
  before_action :load_enrollment, only: [:show, :edit, :update, :destroy]

  attr_reader :enrollment

  def index
    @enrollments = Enrollment.all
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

  def load_enrollment
    id = params[:id]
    @enrollment = Enrollment.find(id)
  end
end
