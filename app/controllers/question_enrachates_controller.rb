class QuestionEnrachatesController < ApplicationController
  before_action :set_question_enrachate, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @question_enrachates = QuestionEnrachate.all
    respond_with(@question_enrachates)
  end

  def show
    respond_with(@question_enrachate)
  end

  def new
    @question_enrachate = QuestionEnrachate.new
    respond_with(@question_enrachate)
  end

  def edit
  end

  def create
    @question_enrachate = QuestionEnrachate.new(question_enrachate_params)
    @question_enrachate.save
    respond_with(@question_enrachate)
  end

  def update
    @question_enrachate.update(question_enrachate_params)
    respond_with(@question_enrachate)
  end

  def destroy
    @question_enrachate.destroy
    respond_with(@question_enrachate)
  end

  private
    def set_question_enrachate
      @question_enrachate = QuestionEnrachate.find(params[:id])
    end

    def question_enrachate_params
      params.require(:question_enrachate).permit(:title, :correct_answer, :answer1, :answer2, :program_date)
    end
end
