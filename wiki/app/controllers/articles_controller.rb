class ArticlesController < ApplicationController
  
  def index
    @articles = Article.all
  end
  
  def create
    # raise(params.to_s)
    @article = Article.new(params[:article])
    
    if @article.save
      redirect_to(article_path(@article.id))
    else
      render :new
    end
  end
  
  def new
    @article = Article.new()
    @update = @article.updates.build
  end
  
  def edit
    @article = Article.find(params[:id])
    @update = @article.updates.last.dup
  end
  
  def show
    @article = Article.find(params[:id])
    @content = @article.updates.last.content
  end
  
  def update
    @article = Article.find(params[:id])
    
    if @article.update_attributes(params[:article])
      redirect_to(article_path(params[:id]))
    else
      render :edit
    end
  end
  
  def destroy
    Article.delete(params[:id])
    redirect_to(articles_path)
  end
end
