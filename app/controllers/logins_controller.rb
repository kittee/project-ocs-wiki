class LoginsController < ApplicationController

  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    
    if user.username && user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:username] = user.username
      session[:inactive] = user.inactive
      redirect_to :root
    else
      redirect_to("/logins/new?invalid_password=true&email=#{params[:email]}")
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to(:root)
  end
end