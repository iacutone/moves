class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :activity]
  respond_to :html, :js

  def index
    @users = User.all
    respond_with(@users)
  end

  def show
    if params[:time].present?
      @moves = MovesApi.new.moves(@user.access_token)
      # @moves = @moves.find_activity.walking_activity
    end
    respond_with(@user)
    # @activity = ActivityCreator.new(moves.daily_activities)
  end

  def new
    @user = User.new
    respond_with(@user)
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    @user.save
    respond_with(@user)
  end

  def update
    @user.update(user_params)
    respond_with(@user)
  end

  def destroy
    @user.destroy
    respond_with(@user)
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:uid, :email, :name, :provider)
    end
end
