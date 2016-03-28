class MeetingsController < ApplicationController
  include GenericResourcefulActions

  before_action :load_meeting, only: [:show, :edit, :update, :destroy]

  attr_reader :meeting
  alias :member_object :meeting
  decorates_assigned :meeting

  def index
    @meetings = Meeting.all
  end

  def show
  end

  def new
    @meeting = Meeting.new
  end

  def edit
  end

  def create
    @meeting = Meeting.new(meeting_params)
    save_and_respond
  end

  def update
    update_and_respond(meeting_params)
  end

  def destroy
    meeting.destroy
    destruction
  end

  private

  def load_meeting
    id = params[:id]
    @meeting = Meeting.find(id)
  end

  def meeting_params
    params.require(:meeting).permit(whitelisted_attr)
  end

  def whitelisted_attr
    [:course_name, :room_name, :start, :length,
     :course_id, :room_id]
  end
end
