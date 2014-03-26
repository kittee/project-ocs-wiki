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
  
  def rollback
    # raise(params.to_s)
    authorize
    admin
    update = Update.create({:article_id => params[:id], :user_id => current_user.id, :content => params[:update][:update]})
    redirect_to(article_path(params[:id]))
  end
  
  def destroy
    authorize
    admin
    Article.delete(params[:id])
    redirect_to(articles_path)
  end
end
