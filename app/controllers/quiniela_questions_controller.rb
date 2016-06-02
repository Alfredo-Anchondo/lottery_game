class QuinielaQuestionsController < ApplicationController
	 load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_quiniela_question, only: [:show, :edit, :update, :destroy]

  respond_to :html
  respond_to :json	

  def index
    @quiniela_questions = QuinielaQuestion.all
    respond_with(@quiniela_questions)
  end

  def show
    respond_with(@quiniela_question)
  end

  def new
    @quiniela_question = QuinielaQuestion.new
    respond_with(@quiniela_question)
  end

  def edit
  end

  def create
    @quiniela_question = QuinielaQuestion.new(quiniela_question_params)
    @quiniela_question.save
    respond_with(@quiniela_question)
  end

  def update
    @quiniela_question.update(quiniela_question_params)
    respond_with(@quiniela_question)
  end

  def destroy
    @quiniela_question.destroy
    respond_with(@quiniela_question)
  end

  private
    def set_quiniela_question
      @quiniela_question = QuinielaQuestion.find(params[:id])
    end

    def quiniela_question_params
		params.require(:quiniela_question).permit(:quiniela_id, :question_id, :value)
    end
end
