class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :data, only: [:index, :new, :create, :edit, :update]
  before_action :authenticate_user!

  # GET /users
  # GET /users.json
  def index
  end

  # GET /users/1
  # GET /users/1.json
  def show
      @user = User.find(params[:id])
  end
    
    def lotteries
        respond_with(@user.user_lotteries,:root=>false)
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
      if @user.update(user_params)
        sign_in(@user, :bypass => true)
          format.html { redirect_to @user, notice: t('success_update') }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
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
      params.require(:user).permit(:name, :last_name, :address_1, :address_2, :zip_code, :age, :email, :phone, :cellphone, :balance, :role_id, :country, :state, :city, :int_number, :photo, :ext_number, :username, :password)
    end
end
