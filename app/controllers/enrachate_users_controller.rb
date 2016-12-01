class EnrachateUsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_enrachate_user, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @enrachate_users = EnrachateUser.all
    respond_with(@enrachate_users)
  end

  def show
    respond_with(@enrachate_user)
  end

  def new
    @enrachate_user = EnrachateUser.new
    respond_with(@enrachate_user)
  end

  def edit
  end

  def create
    @enrachate_user = EnrachateUser.new(enrachate_user_params)
    @enrachate_user.save
    respond_with(@enrachate_user)
  end

  def update
    @enrachate_user.update(enrachate_user_params)
    respond_with(@enrachate_user)
  end

  def destroy
    @enrachate_user.destroy
    respond_with(@enrachate_user)
  end

  private
    def set_enrachate_user
      @enrachate_user = EnrachateUser.find(params[:id])
    end

    def enrachate_user_params
      params.require(:enrachate_user).permit(:question_enrachate_id, :tira_enrachate_id, :answer, :user_id, :status, :purchase_date, :enrachate_user_id, :enrachates_id)
    end
end
