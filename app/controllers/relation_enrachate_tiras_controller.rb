class RelationEnrachateTirasController < ApplicationController
  before_action :set_relation_enrachate_tira, only: [:show, :edit, :update, :destroy]

  respond_to :html
  respond_to :json

    def tiras_for_enrachate
      render :json =>  TiraEnrachate.all.order(program_date: :desc)
        end

    def close_question
         @tira_id = params[:tira_id]
         @question_id = params[:question_id]
         @answer = params[:answer]
         @winner = false
         @winner_user = ""
         if @answer == "1"
         @incorrect_answer = "2"
             else
          @incorrect_answer = "1"
         end

         @question = QuestionEnrachate.find(@question_id)

         if @question.correct_answer != nil && @question.correct_answer != "" && @question.correct_answer != []
         else


         @question.update(:correct_answer => @answer)

         @tickets_for_tira = EnrachateUser.where("question_enrachate_id = ? and tira_enrachate_id = ?  and answer = ?",@question_id, @tira_id, @answer.to_s)

         @tickets_for_tira.each do |ticket|
             ticket.update(:status => "alive")
             BuyMailer.close_question(ticket.user.email, "Vivo" ,ticket).deliver
          @racha_count = EnrachateUser.where("enrachate_user_id = ? and status = ? ",  ticket.enrachate_user_id, "alive").count
          if ticket.enrachates_id == 18
            @special_enrachate = Enrachate.find(ticket.enrachates_id)
            if @racha_count == @special_enrachate.max_racha
                ticket.user.update(:balance => ticket.user.balance + @special_enrachate.initial_balance )
                ticket.update(:status => "Winner")
            end
          else
          if @racha_count == 25
               @winner = true
               @winner_user = ticket.user
          end
        end
         end

         @incorrects_tickets_for_tira = EnrachateUser.where("question_enrachate_id = ? and tira_enrachate_id = ?  and answer = ?",@question_id, @tira_id, @incorrect_answer)

         logger.info  @incorrects_tickets_for_tira.count
        if @incorrects_tickets_for_tira.count > 1

         @incorrects_tickets_for_tira.each do |iticket|
           if iticket.enrachates_id == 18
             @racha_count_los = EnrachateUser.where("enrachate_user_id = ? and status = ? ",  iticket.enrachate_user_id, "alive").count
             @special_enrachate_los = Enrachate.find(iticket.enrachates_id)
             logger.info "Entre a la de especial"
             logger.info @special_enrachate_los
             if @racha_count_los == (@special_enrachate_los.max_racha - 1)
                 iticket.user.update(:balance => iticket.user.balance + @special_enrachate_los.second_prize )
                 iticket.update(:status => "Winner_second")
                 BuyMailer.close_question(iticket.user.email, "Perdedor" ,iticket).deliver
             end
             if @racha_count_los == (@special_enrachate_los.max_racha - 2)
                 iticket.user.update(:balance => iticket.user.balance + @special_enrachate_los.third_prize )
                 iticket.update(:status => "Winner_third")
                 BuyMailer.close_question(iticket.user.email, "Perdedor" ,iticket).deliver
             end
             if @racha_count_los != (@special_enrachate_los.max_racha - 2) && @racha_count_los != (@special_enrachate_los.max_racha - 1)
               iticket.update(:status => "loser")
               BuyMailer.close_question(iticket.user.email, "Perdedor" ,iticket).deliver
             end
           else
             iticket.update(:status => "loser")
             BuyMailer.close_question(iticket.user.email, "Perdedor" ,iticket).deliver
           end

         end

       else
          if @incorrects_tickets_for_tira.count != 0
         @racha_count_los = EnrachateUser.where("enrachate_user_id = ? and status = ? ",  @incorrects_tickets_for_tira.first.enrachate_user_id, "alive").count
         @special_enrachate_los = Enrachate.find(@incorrects_tickets_for_tira.first.enrachates_id)
         logger.info "Entre a la de especial"
         logger.info @special_enrachate_los
         if @racha_count_los == (@special_enrachate_los.max_racha - 1)
             @incorrects_tickets_for_tira.first.user.update(:balance => @incorrects_tickets_for_tira.first.user.balance + @special_enrachate_los.second_prize )
             @incorrects_tickets_for_tira.first.update(:status => "Winner_second")
             BuyMailer.close_question(@incorrects_tickets_for_tira.first.user.email, "Perdedor" ,@incorrects_tickets_for_tira.first).deliver
         end
         if @racha_count_los == (@special_enrachate_los.max_racha - 2)
            @incorrects_tickets_for_tira.first.user.update(:balance => @incorrects_tickets_for_tira.first.user.balance + @special_enrachate_los.third_prize )
             @incorrects_tickets_for_tira.first.update(:status => "Winner_third")
             BuyMailer.close_question(@incorrects_tickets_for_tira.first.user.email, "Perdedor" ,@incorrects_tickets_for_tira.first).deliver
         end
         if @racha_count_los != (@special_enrachate_los.max_racha - 2) && @racha_count_los != (@special_enrachate_los.max_racha - 1)
           @incorrects_tickets_for_tira.first.update(:status => "loser")
           BuyMailer.close_question(@incorrects_tickets_for_tira.first.user.email, "Perdedor" ,@incorrects_tickets_for_tira.first).deliver
         end

       end
     end
     end

         RelationEnrachateTira.where("tira_enrachate_id = ?", @tira_id).each do |tira_enrachate_relat|
           @enrachate = tira_enrachate_relat.enrachate

           logger.info   @enrachate.name
           logger.info "NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN"

         if  @winner == true
           if @enrachate.type_enrachate == 0
           @winner_user.update(:balance => @winner_user.balance + @enrachate.initial_balance )
           @enrachate.update(:winner => @winner_user.id )
           end
         end

         if @enrachate.type_enrachate == 1
          @pending_question = false
           RelationTiraQuestion.where("tira_enrachate_id = ?",@tira_id).each do |question|
             if question.question_enrachate.correct_answer == nil || question.question_enrachate.correct_answer == ""
               logger.info "Entre por que ya no hay preguntas pendientes"
               @pending_question = true
             end
           end
           if @pending_question == false
             @winner_ticket =  EnrachateUser.where("enrachates_id = ? and status = ? and tira_enrachate_id = ?", @enrachate.id, "Winner", @tira_id)
             @no_choose_tickets = EnrachateUser.where("enrachates_id = ? and status = ? and tira_enrachate_id = ? and question_enrachate_id IS NULL", @enrachate.id, "bought", @tira_id)
             @bought_tickets = EnrachateUser.where("enrachates_id = ? and status = ? and tira_enrachate_id = ?", @enrachate.id, "bought", @tira_id).where.not(:question_enrachate_id => nil)
             @alive_tickets = EnrachateUser.where("enrachates_id = ? and status = ? and tira_enrachate_id = ?", @enrachate.id, "alive", @tira_id)
             if  @winner_ticket.count == 0

              if @bought_tickets.count == 0
                logger.info "Entre por que ya no hay boletos con estado comprado y vacios"
                @no_choose_tickets.each do |ticketx|
                  ticketx.update(:status => "loser")
                  BuyMailer.close_question(ticketx.user.email, "Perdedor" ,ticketx).deliver
                end
                if  @alive_tickets.count == 0
                  logger.info "Entre a donde no hay ningun vivo"
                   @last = EnrachateUser.where("enrachates_id = ? and status = ? and tira_enrachate_id = ?", @enrachate.id, "loser", @tira_id)
                   @quantity = @last.length
                   @balance_porcent = @enrachate.initial_balance / @quantity
                   @last.each do |winner|
                      winner.user.update(:balance => winner.user.balance + @balance_porcent)
                      winner.update(:status => "Winner")
                      @enrachate.update(:winner => winner.user.id )
                   end
                end
                 if  @alive_tickets.count == 1
                   logger.info "Entre al de solo un vivo"
                    @survivor_winner = EnrachateUser.where("enrachates_id = ? and status = ? and tira_enrachate_id = ?", @enrachate.id, "alive", @tira_id).first
                    @survivor_winner.user.update(:balance => @survivor_winner.user.balance + @enrachate.initial_balance)
                    @survivor_winner.update(:status => "Winner")
                    @enrachate.update(:winner => @survivor_winner.user.id )
                 end
                 if  @enrachate.end_date.to_date == DateTime.now.to_date
                   logger.info "Entre al de fin de temporada"
                   @quantity = @alive_tickets.length
                   @balance_porcent = @enrachate.initial_balance / @quantity
                   @alive_tickets.each do |winner|
                     winner.user.update(:balance => winner.user.balance + @balance_porcent)
                     winner.update(:status => "Winner")
                     @enrachate.update(:winner => winner.user.id )
                   end
                 end
              end
            else
              logger.info "Ya hay ganador"
            end
           end
         end
       end


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
