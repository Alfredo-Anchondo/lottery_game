class RelationEnrachateTirasController < ApplicationController
  before_action :set_relation_enrachate_tira, only: [:show, :edit, :update, :destroy]

  respond_to :html
  respond_to :json
    
    def tiras_for_enrachate
        @enrachate = Enrachate.find(params[:enrachate_id])
     respond_to do |format|
   format.json { render :json => @enrachate }
end
        end
    
    def close_question
         @tira_id = params[:tira_id]
         @question_id = params[:question_id]
         @answer = params[:answer]
         if @answer == "1"
         @incorrect_answer = "2"     
             else
          @incorrect_answer = "1"     
         end
        
         @enrachate_id = params[:enrachate_id]
        
         @tickets_for_tira = EnrachateUser.where("question_enrachate_id = ? and tira_enrachate_id = ? and enrachates_id = ? and answer = ?",@question_id, @tira_id, @enrachate_id, @answer.to_s)
         
         @tickets_for_tira.each do |ticket|
             ticket.update(:status => "alive")
         end

         @incorrects_tickets_for_tira = EnrachateUser.where("question_enrachate_id = ? and tira_enrachate_id = ? and enrachates_id = ? and answer = ?",@question_id, @tira_id, @enrachate_id, @incorrect_answer) 
        
         @incorrects_tickets_for_tira.each do |iticket|
             iticket.update(:status => "loser") 
         end
        
         @question = QuestionEnrachate.find(@question_id)
         @question.update(:correct_answer => @answer)
        
          respond_to do |format|
           format.json { render :json => true }
        end
       
    end

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
