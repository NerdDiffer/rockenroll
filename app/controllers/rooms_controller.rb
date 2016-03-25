class RoomsController < ApplicationController
  before_action :load_room, only: [:show, :edit, :update, :destroy]

  attr_reader :room

  def index
    @rooms = Room.all
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

  def load_room
    id = params[:id]
    @room = Room.find(id)
  end
end
