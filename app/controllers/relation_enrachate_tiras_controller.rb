class RelationEnrachateTirasController < ApplicationController
  before_action :set_relation_enrachate_tira, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @relation_enrachate_tiras = RelationEnrachateTira.all
    respond_with(@relation_enrachate_tiras)
  end

  def show
    respond_with(@relation_enrachate_tira)
  end

  def new
    @relation_enrachate_tira = RelationEnrachateTira.new
    respond_with(@relation_enrachate_tira)
  end

  def edit
  end

  def create
    @relation_enrachate_tira = RelationEnrachateTira.new(relation_enrachate_tira_params)
    @relation_enrachate_tira.save
    respond_with(@relation_enrachate_tira)
  end

  def update
    @relation_enrachate_tira.update(relation_enrachate_tira_params)
    respond_with(@relation_enrachate_tira)
  end

  def destroy
    @relation_enrachate_tira.destroy
    respond_with(@relation_enrachate_tira)
  end

  private
    def set_relation_enrachate_tira
      @relation_enrachate_tira = RelationEnrachateTira.find(params[:id])
    end

    def relation_enrachate_tira_params
      params.require(:relation_enrachate_tira).permit(:enrachate_id, :tira_enrachate_id)
    end
end
