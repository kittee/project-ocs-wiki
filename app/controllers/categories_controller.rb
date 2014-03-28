class CategoriesController < ApplicationController
  before_filter :revoke, :authorize, :admin
  
  def index
    @categories = Category.all
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(params[:category])
    
    if @category.save
      redirect_to(:categories)
    else
      render "new"
    end
  end
  
  def show
    @category = Category.find(params[:id])
  end
  
  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    @category.update_attributes(params[:category])
    
    redirect_to(:categories)
  end
  
  def destroy
    @category = Category.find(params[:id])
    @category.delete
    
    redirect_to(:categories)
  end
end