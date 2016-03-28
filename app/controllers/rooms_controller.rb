class RoomsController < ApplicationController
  include GenericResourcefulActions

  before_action :load_room, only: [:show, :edit, :update, :destroy]

  attr_reader :room
  alias :member_object :room
  decorates_assigned :room

  def index
    @rooms = Room.all
  end

  def show
  end

  def new
    @room = Room.new
  end

  def edit
  end

  def create
    @room = Room.new(room_params)
    save_and_respond
  end

  def update
    update_and_respond(room_params)
  end

  def destroy
    room.destroy
    destruction
  end

  private

  def load_room
    id = params[:id]
    @room = Room.find(id)
  end

  def room_params
    params.require(:room).permit(whitelisted_attr)
  end

  def whitelisted_attr
    [:name]
  end
end
