class Api::V1::LoginController < ApplicationController

  def next_game
      render :json => Game.next_game
  end



  def check_auth
    authenticate_or_request_with_http_basic do |username,password|
      resource = User.find_by_email(username)
      if resource.valid_password?(password)
        sign_in :user, resource
      end
    end
  end

  def login
    render json: true
  end

end
