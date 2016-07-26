class PickUsersController < ApplicationController
  before_action :set_pick_user, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @pick_users = PickUser.all
    respond_with(@pick_users)
  end

  def show
    respond_with(@pick_user)
  end

  def new
    @pick_user = PickUser.new
    respond_with(@pick_user)
  end

  def edit
  end

  def create
    @pick_user = PickUser.new(pick_user_params)
    @pick_user.save
    #respond_with(@pick_user)
	render json: nil, status: :ok
  end

  def update
    @pick_user.update(pick_user_params)
    respond_with(@pick_user)
  end

  def destroy
    @pick_user.destroy
    respond_with(@pick_user)
  end

  private
    def set_pick_user
      @pick_user = PickUser.find(params[:id])
    end

    def pick_user_params
      params.require(:pick_user).permit(:user_id, :pick_survivor_week_id, :points, :local_score, :visit_score, :pick_user_id)
    end
end
