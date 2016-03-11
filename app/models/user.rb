class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
          :rememberable, :trackable, :validatable

      #Associations
     belongs_to :role
    has_many :user_lotteries
    has_attached_file :photo,
    :styles => { :medium => "x300",
    :mobile => "x240" }
    
    #Validations
    validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  

      def select_display
        name + " " + last_name
    end
    
    def self.email_in_lottery(lottery_id_param, winner_number, lottery_name)
        emails = where(:id => UserLottery.where(:lottery_id => lottery_id_param).pluck(:user_id).uniq).pluck(:email)
        logger.info emails
        BuyMailer.winner_number(emails, winner_number, lottery_name).deliver
    end  
    
    
    def self.winner_user(lottery_id_param, winner_number, lottery_name, winner_number_param, initial_balance)
        user = where(:id => UserLottery.where(:lottery_id => lottery_id_param, :ticket_number => winner_number_param).pluck(:user_id).uniq).first
        
        if user.present?
             winner = user.email
             user_winner =  user.id
             logger.info winner
             logger.info user_winner
             BuyMailer.winner_congratulations(winner, winner_number, lottery_name).deliver
             User.find_by_id(user_winner).update(:balance => (user.balance + initial_balance)) 
             update_winner = UserLottery.where(:lottery_id => lottery_id_param, :ticket_number => winner_number_param, :user_id => user_winner).pluck(:id)
             UserLottery.find_by_id(update_winner).update(:status => "Ganador") 
        end    
    end   
    
    
      def password_required?
    !persisted? || !password.blank? || !password_confirmation.blank?
  end
    
end