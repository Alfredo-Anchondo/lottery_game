class WelcomeController < ApplicationController
	before_action :authenticate_user!, except: ["terms"]
  def index
  end
end
