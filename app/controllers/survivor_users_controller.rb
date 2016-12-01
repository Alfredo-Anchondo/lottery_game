class SurvivorUsersController < ApplicationController
  load_and_authorize_resource except: [:new,:create]
  before_action :authenticate_user!
  before_action :set_survivor_user, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
    @survivor_users = SurvivorUser.all
    respond_with(@survivor_users)
  end

  def show
    respond_with(@survivor_user)
  end

  def new
    @survivor_user = SurvivorUser.new
    respond_with(@survivor_user)
  end

  def edit
  end

  def create
    @survivor_user = SurvivorUser.new(survivor_user_params)
    @survivor_user.save
    respond_with(@survivor_user)
  end

  def update
    @survivor_user.update(survivor_user_params)
    respond_with(@survivor_user)
  end

  def destroy
    @survivor_user.destroy
    respond_with(@survivor_user)
  end

  private
    def set_survivor_user
      @survivor_user = SurvivorUser.find(params[:id])
    end

    def survivor_user_params
      params.require(:survivor_user).permit(:survivor_week_survivor_id, :survivor_user_id, :team_id, :purchase_date, :user_id, :status)
    end
end
