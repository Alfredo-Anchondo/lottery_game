class EnrachatesController < ApplicationController
  load_and_authorize_resource
  before_action :set_enrachate, only: [:show, :edit, :update, :destroy]

  respond_to :html




  def index
    @enrachates = Enrachate.all
    respond_with(@enrachates)
  end

  def show
    respond_with(@enrachate)
  end

  def new
    @enrachate = Enrachate.new
    respond_with(@enrachate)
  end

  def edit
  end

  def create
    @enrachate = Enrachate.new(enrachate_params)
    @enrachate.save
    respond_with(@enrachate)
  end

  def update
    @enrachate.update(enrachate_params)
    respond_with(@enrachate)
  end

  def destroy
    @enrachate.destroy
    respond_with(@enrachate)
  end

  private
    def set_enrachate
      @enrachate = Enrachate.find(params[:id])
    end

    def enrachate_params
      params.require(:enrachate).permit(:price, :user_id, :access_key, :name, :initial_balance, :percentage, :type_enrachate, :description, :winner, :initial_date, :end_date, :max_racha, :second_prize, :third_prize)
    end
end
