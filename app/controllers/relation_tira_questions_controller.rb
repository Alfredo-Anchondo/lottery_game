class RelationTiraQuestionsController < ApplicationController
  before_action :set_relation_tira_question, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @relation_tira_questions = RelationTiraQuestion.all
    respond_with(@relation_tira_questions)
  end

  def show
    respond_with(@relation_tira_question)
  end

  def new
    @relation_tira_question = RelationTiraQuestion.new
    respond_with(@relation_tira_question)
  end

  def edit
  end

  def create
    @relation_tira_question = RelationTiraQuestion.new(relation_tira_question_params)
    @relation_tira_question.save
    respond_with(@relation_tira_question)
  end

  def update
    @relation_tira_question.update(relation_tira_question_params)
    respond_with(@relation_tira_question)
  end

  def destroy
    @relation_tira_question.destroy
    respond_with(@relation_tira_question)
  end

  private
    def set_relation_tira_question
      @relation_tira_question = RelationTiraQuestion.find(params[:id])
    end

    def relation_tira_question_params
      params.require(:relation_tira_question).permit(:tira_enrachate_id, :question_enrachate_id)
    end
end
