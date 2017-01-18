class Api::V1::UserLoginController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
before_action :authenticate_user!
  def next_game
      render :json => Game.next_game
  end
end
