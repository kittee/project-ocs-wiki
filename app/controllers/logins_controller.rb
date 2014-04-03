class LoginsController < ApplicationController

  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    
    if user && user.authenticate(params[:password])
      if !user.confirmed
        flash[:notice] = "Account has not been confirmed. Please check your email."
        redirect_to(:new_login)
      elsif user.inactive
        flash[:alert] = "Account has been disabled."
        redirect_to(:new_login)
      else
        session[:user_id] = user.id
        session[:username] = user.username
        session[:inactive] = user.inactive
        redirect_to :root
      end
    else
      flash[:notice] = "Invalid email address or password"
      redirect_to(:new_login)
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to(:root)
  end
end