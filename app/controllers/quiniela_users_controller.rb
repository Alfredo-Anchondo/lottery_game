class QuinielaUsersController < ApplicationController
  before_action :set_quiniela_user, only: [:show, :edit, :update, :destroy]

  respond_to :html
  respond_to :json	

	def winners
		render :json => (QuinielaUser.winners)
	end
	
  def index
    @quiniela_users = QuinielaUser.all
    respond_with(@quiniela_users)
  end

  def show
    respond_with(@quiniela_user)
  end

  def new
    @quiniela_user = QuinielaUser.new
    respond_with(@quiniela_user)
  end

  def edit
  end

  def create
    @quiniela_user = QuinielaUser.new(quiniela_user_params)
    @quiniela_user.save
    respond_with(@quiniela_user)
  end

  def update
    @quiniela_user.update(quiniela_user_params)
    respond_with(@quiniela_user)
  end

  def destroy
    @quiniela_user.destroy
    respond_with(@quiniela_user)
  end

  private
    def set_quiniela_user
      @quiniela_user = QuinielaUser.find(params[:id])
    end

    def quiniela_user_params
		params.require(:quiniela_user).permit(:user_id, :quiniela_id, :ticket_number, :status, :purchase_date)
    end
end
