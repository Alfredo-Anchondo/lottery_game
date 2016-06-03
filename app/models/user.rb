class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
          :rememberable, :trackable, :timeoutable, :validatable,:recoverable
#, :omniauthable, :omniauth_providers => [:facebook, :twitter]
      #Associations
    belongs_to :role
    has_many :user_lotteries
	has_many :quiniela_users
    has_attached_file :photo,
    :styles => { :medium => "x300",
    :mobile => "x240" }
    
    #Validations
    validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  
def self.from_omniauth(auth)
	r = rand(0...10000)
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.name = auth.info.first_name  # assuming the user model has a name
    user.username = auth.info.name
    user.last_name =  auth.info.last_name
	user.friend_reference = "DB"+auth.info.name.gsub(/\s+/, "").upcase+String(r)+"REF"   
    user.role_id = '2'  
  end
end
    
    def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
	r = rand(0...10000)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.uid + "@twitter.com").first
      if registered_user
        return registered_user
      else

        user = User.create( name:auth.extra.raw_info.name,
                            username:auth.info.nickname,
                            provider:auth.provider,
                            uid:auth.uid,
                            email:auth.uid+"@twitter.com",
                            role_id: 2,
							friend_reference: "DB"+auth.info.nickname.gsub(/\s+/, "").upcase+String(r)+"REF",
                            last_name: auth.extra.raw_info.name,
                            password:Devise.friendly_token[0,20],
                          )
      end

    end
  end

    
    def lottery_count
        Lottery.count
    end
    
    def users_count
        User.count
    end    
    
    def teams_count
        Team.count
    end
    
    def get_time
        Time.now.strftime("%d/%m/%Y %l:%M %p")
    end    
    
    def user_lotteries_count
        UserLottery.count 
    end
	
	def total_balances
		@users = User.all
		logger.info @users
		@balance = 0
		@users.each do |balance|
			if balance.balance
			@balance = @balance + Integer(balance.balance)
			end
		end
		return @balance
    end
	
	def total_gift_balances
		@users = User.all
		logger.info @users
		@balance = 0
		@users.each do |balance|
			if balance.gift_credit
				@balance = @balance + Integer(balance.gift_credit)
			end
		end
		return @balance
    end
	
	def tickets_tiras_count
		QuinielaUser.count 
    end
	
	def games_count
		Game.count 
    end
	
	def sports_count
		Sport.count 
    end
	
	  def user_tiras_count
		  Quiniela.count 
      end
	
	def ticket_purchase_lottery
		UserLottery.where('user_id = ?', id).count
	end
	
	def ticket_purchase_quiniela
		QuinielaUser.where('user_id = ?', id).count
	end
	
	def self.search_reference1(reference)
		where('friend_reference = ?', reference).pluck(:id)
	end	
    
    
    def select_display
		name + " " + last_name + " |username: " + username + ""
    end
    
    
    def self.email_in_lottery(lottery_id_param, winner_number, lottery_name)
        emails = where(:id => UserLottery.where(:lottery_id => lottery_id_param).pluck(:user_id).uniq).pluck(:email)
        logger.info emails
		if emails != nil && emails != '' && emails != []
			emails.each do|mail|
				 BuyMailer.winner_number(mail, winner_number, lottery_name).deliver
			end
			
		end
    end  
	
	 
	def self.email_in_quiniela(quiniela_id_param, winner_number, quiniela_name)
		emails = where(:id => QuinielaUser.where(:quiniela_id => quiniela_id_param).pluck(:user_id).uniq).pluck(:email)
        logger.info emails
		if emails != nil && emails != '' && emails != []
			emails.each do |mail|
				BuyMailer.winner_number_quiniela(mail, winner_number, quiniela_name).deliver
			end			
		end
    end  
    
    
    def self.winner_user(lottery_id_param, winner_number, lottery_name, winner_number_param, initial_balance)
        users = where(:id => UserLottery.where(:lottery_id => lottery_id_param, :ticket_number => String(winner_number_param)).pluck(:user_id).uniq).all
        
        if users.count <= 1 
            if users.present?
             winner = users[0].email
             user_winner =  users[0].id
             logger.info winner
             logger.info user_winner
             BuyMailer.winner_congratulations(winner, winner_number, lottery_name, initial_balance, 1).deliver
             User.find_by_id(user_winner).update(:balance => (users[0].balance + initial_balance)) 
             update_winner = UserLottery.where(:lottery_id => lottery_id_param, :ticket_number => String(winner_number_param), :user_id => user_winner).pluck(:id)
             UserLottery.find_by_id(update_winner).update(:status => "Ganador") 
            end    
        else
            count = users.count
            total_update = initial_balance / count
            logger.info count 
            logger.info initial_balance
            logger.info total_update
            
            users.each do |variable|
            logger.info variable.email 
            winner = variable.email
            user_winner =  variable.id
            BuyMailer.winner_congratulations(winner, winner_number, lottery_name, total_update, count).deliver
            User.find_by_id(user_winner).update(:balance => (variable.balance + total_update)) 
             update_winner = UserLottery.where(:lottery_id => lottery_id_param, :ticket_number => String(winner_number_param), :user_id => user_winner).pluck(:id)
             UserLottery.find_by_id(update_winner).update(:status => "Ganador") 
            end
        
        end 
    
    
    end   
	
	def self.winner_quiniela_user(quiniela_id_param, winner_number, quiniela_name, winner_number_param, initial_balance)
		users = where(:id => QuinielaUser.where(:quiniela_id => quiniela_id_param, :ticket_number => String(winner_number_param)).pluck(:user_id).uniq).all
        
        if users.count <= 1 
            if users.present?
             winner = users[0].email
             user_winner =  users[0].id
             logger.info winner
             logger.info user_winner
			 BuyMailer.winner_congratulations_quiniela(winner, winner_number, quiniela_name, initial_balance, 1).deliver
             User.find_by_id(user_winner).update(:balance => (users[0].balance.to_f + initial_balance.to_f)) 
				update_winner = QuinielaUser.where(:quiniela_id => quiniela_id_param, :ticket_number => String(winner_number_param), :user_id => user_winner).pluck(:id)
				QuinielaUser.find_by_id(update_winner).update(:status => "Ganador") 
            end    
        else
            count = users.count
            total_update = initial_balance.to_f / count
            logger.info count 
            logger.info initial_balance
            logger.info total_update
            
            users.each do |variable|
            logger.info variable.email 
            winner = variable.email
            user_winner =  variable.id
			BuyMailer.winner_congratulations(winner, winner_number, quiniela_name, total_update, count).deliver
            User.find_by_id(user_winner).update(:balance => (variable.balance.to_f + total_update.to_f)) 
			update_winner = QuinielaUser.where(:quiniela_id => quiniela_id_param, :ticket_number => String(winner_number_param), :user_id => user_winner).pluck(:id)
			QuinielaUser.find_by_id(update_winner).update(:status => "Ganador") 
            end
        
        end 
    
    
    end   
    
    
      def password_required?
    !persisted? || !password.blank? || !password_confirmation.blank?
  end
    
end