class ArticlesController < ApplicationController
  
  def index
    @articles = Article.all
  end
  
  def create
    authorize
    # raise(params.to_s)
    @article = Article.new(params[:article])
    
    if @article.save
      redirect_to(article_path(@article.slug))
    else
      render :new
    end
  end
  
  def new
    authorize
    @article = Article.new()
    @update = @article.updates.build
  end
  
  def edit
    authorize
    @article = Article.find(params[:id])
    
    if @article.locked && !current_user.admin
      @content = @article.updates.last.content
      @error="Article is locked. You cannot edit at this time."
      render :show
    end
    
    @update = @article.updates.last.dup
  end
  
  def show
    @article = Article.find(params[:id])
    @content = @article.updates.last.content
  end
  
  def update
    authorize
    @article = Article.find(params[:id])
    
    if @article.update_attributes(params[:article])
      redirect_to(article_path(@article.slug))
    else
      render :edit
    end
  end
  
  def destroy
    authorize
    admin
    Article.delete(params[:id])
    redirect_to(articles_path)
  end
end
