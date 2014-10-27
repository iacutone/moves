class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :activity]
  respond_to :html, :js

  def show
    if params[:time].present?
      @moves = MovesApi.new(@user.access_token, params[:time])
      @steps = @moves.find_steps
      @times = @moves.find_times
    end
    respond_with(@user)
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
