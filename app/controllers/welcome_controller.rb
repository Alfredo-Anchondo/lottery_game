class WelcomeController < ApplicationController
	before_action :authenticate_user!
	
  def index
  end
	
	def verification_page
		render 'welcome/$MISCKEY'
	end	
	
end
