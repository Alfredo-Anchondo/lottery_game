class UsersController < ApplicationController
	  load_and_authorize_resource

     before_action :set_user, only: [:show, :edit, :update, :destroy]
     before_action :data, only: [:index, :new,  :edit, :update]
	   before_action :authenticate_user!, except: 'search_reference'
	   respond_to :html
  	 respond_to :json

  # GET /users
  # GET /users.json
  def index
  end

  # GET /users/1
  # GET /users/1.json
  def show
      @user = User.find(params[:id])
  end


def activity_of_day
  @date_param =	params[:date]
	@lottery_ticket = UserLottery.where("purchase_date::date = ?",@date_param.to_date)
	@enrachate_ticket = EnrachateUser.where("purchase_date::date = ?", @date_param.to_date)
  @quiniela_ticket = QuinielaUser.where("purchase_date::date = ?",@date_param.to_date)
end


	def send_mails_all
		logger.info "Entre en el primer metodo"
		User.delay.send_mails_all(params[:emails], params[:content], params[:subject])
		render json: true
	end


	def search_reference
		reference = params[:reference]
		render :json => User.search_reference1(reference)
	end

	def client_details
		@user = User.find(params[:id_client])
		@tickets = UserLottery.where(user_id: params[:id_client]).order(lottery_id: :desc);
		@tira = QuinielaUser.where(user_id: params[:id_client]).order(quiniela_id: :desc);
		@recomend = User.where(reference_by_friend: @user.friend_reference)
		respond_with(@user)
	end


    def lotteries
      @user = User.find(params[:id])
      respond_with(@user.user_lotteries)
    end

	def quinielas
      @user = User.find(params[:id])
	  respond_with(@user.quiniela_users)
    end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
     @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create

    @user = User.new(user_params)
    @user.save
    respond_with(@user)
    BuyMailer.welcome_user(@user).deliver
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
        if @user.password_changed?
        sign_in(@user, :bypass => true)
        else
        if @user.update(user_params)
        format.html { redirect_to "/", notice: t('success_update') }
        format.json { render :show, status: :ok, location: "/" }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
     end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :last_name, :address_1, :address_2, :zip_code, :age, :email, :phone, :cellphone, :balance, :role_id, :country, :state, :city, :int_number, :photo, :ext_number, :username, :password, :openpay_id, :favorite_team, :birthday, :gender, :language, :friend_reference, :gift_credit, :reference_by_friend)
    end
end
