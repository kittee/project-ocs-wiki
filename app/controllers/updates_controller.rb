class UpdatesController < ApplicationController
  before_filter :authorize, :revoke
  
  def index
    @updates = Update.all
  end
  
  def create
    @new_update = Update.new(params[:update])
    
    if @new_update.save
      redirect_to(update_path(@new_update.id))
    else
      @update = Update.new(params[:update])
      render :new
    end
  end
  
  def new
    @update = Update.new
  end
  
  def edit
  end
  
  def show
    @update = Update.find(params[:id])
  end
  
  def update
  end
  
  def destroy
  end
end