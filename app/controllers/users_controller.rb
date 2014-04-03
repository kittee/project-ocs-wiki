class UsersController < ApplicationController
  before_filter :revoke
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end
  
  def edit
    if current_user.username == params[:id] || current_user.admin
      @user = User.find(params[:id])
    else
      redirect_to(:root)
    end
  end

  def create
    @user = User.new(params[:user])
    @user.confirm_key = Digest::SHA1.hexdigest @user.email
    
    if @user.save
      UserMailer.confirm_email(@user).deliver
      # session[:user_id] = @user.id # "auto-login"
      flash[:notice] = "Please check your email to confirm your account."
      redirect_to(:root)
    else
      render "new"
    end
  end
  
  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    
    redirect_to(:root)
  end

  def destroy
    # @user = User.find(params[:id])
    # if current_user.id = @user.id
    #   session[:user_id] = nil
    # end
    # @user.delete
    flash[:alert] = "Accounts cannot be removed, only deactivated."
    redirect_to(:users)
  end
  
  def deactivate
    user = User.find(params[:id])
    user.update_attribute(:inactive, "true")
    
    if current_user.id == user.id
      session[:user_id] = nil
      flash[:notice] = "Your account has been deactivated. Sorry to see you go."
    else
      flash[:notice] = "#{user.username}'s account has been deactivated."
    end
    
    redirect_to(:root)
  end

  def activate
    user = User.find(params[:id])
    user.update_attribute(:inactive, "false")
    
    redirect_to(:root)
  end
  
  def confirm
    @key = params[:key]
    @user = User.find_by_confirm_key(@key)
    
    if !@user.confirmed
      @user.update_attribute(:confirmed, true)
      session[:user_id] = @user.id # auto-login
      flash[:notice] = "Account successfully confirmed."
      redirect_to(:root)
    elsif @user.confirmed
      flash[:alert] = "Account has already been confirmed. Please log in."
      redirect_to(:new_login)
    else
      flash[:alert] = "Invalid Confirmation."
      redirect_to(:root)
    end
  end

end