class UsersController < ApplicationController
  before_action :load_user, only: [:show, :edit, :update, :destroy]

  attr_reader :user

  def index
    @users = User.all
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

  def load_user
    id = params[:id]
    @user = User.find(id)
  end
end
