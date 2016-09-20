class TiraEnrachatesController < ApplicationController
  before_action :set_tira_enrachate, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @tira_enrachates = TiraEnrachate.all
    respond_with(@tira_enrachates)
  end

  def show
    respond_with(@tira_enrachate)
  end

  def new
    @tira_enrachate = TiraEnrachate.new
    respond_with(@tira_enrachate)
  end

  def edit
  end

  def create
    @tira_enrachate = TiraEnrachate.new(tira_enrachate_params)
    @tira_enrachate.save
    respond_with(@tira_enrachate)
  end

  def update
    @tira_enrachate.update(tira_enrachate_params)
    respond_with(@tira_enrachate)
  end

  def destroy
    @tira_enrachate.destroy
    respond_with(@tira_enrachate)
  end

  private
    def set_tira_enrachate
      @tira_enrachate = TiraEnrachate.find(params[:id])
    end

    def tira_enrachate_params
      params.require(:tira_enrachate).permit(:program_date, :name)
    end
end
