class WelcomeController < ApplicationController
	before_action :authenticate_user!
	
  def index
       @lotteries = Lottery.where(:to_mainpage => true)
       @tiras = Quiniela.where(:to_mainpage => true)
       @survivors = Survivor.where(:to_mainpage => true)
       @picks = Pick.where(:to_mainpage => true)
  end
    
      
      
	
	
end
