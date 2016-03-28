class UsersController < ApplicationController
  include GenericResourcefulActions

  before_action :load_user, only: [:show, :edit, :update, :destroy]

  attr_reader :user
  alias :member_object :user
  decorates_assigned :user


  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    save_and_respond
  end

  def update
    update_and_respond(user_params)
  end

  def destroy
    user.destroy
    destruction
  end

  private

  def load_user
    id = params[:id]
    @user = User.find(id)
  end

  def user_params
    params.require(:user).permit(whitelisted_attr)
  end

  def whitelisted_attr
    [:email, :password, :provider, :uid, :phone, :person_id]
  end
end
