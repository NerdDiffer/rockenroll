class MeetingsController < ApplicationController
  before_action :load_meeting, only: [:show, :edit, :update, :destroy]

  attr_reader :course

  def index
    @meetings = Meeting.all
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

  def load_meeting
    id = params[:id]
    @meeting = Meeting.find(id)
  end
end
