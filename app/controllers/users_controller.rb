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
    
    if @user.save
      session[:user_id] = @user.id # "auto-login"
      
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
    @user = User.find(params[:id])
    if current_user.id = @user.id
      session[:user_id] = nil
    end
    @user.delete
    
    redirect_to(:users)
  end
  
  def deactivate
    @user = User.find(params[:id])
    @user.update_attribute(:inactive, "true")
    
    redirect_to(:root)
  end

  def activate
    @user = User.find(params[:id])
    @user.update_attribute(:inactive, "false")
    
    redirect_to(:root)
  end

end