class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
  
  def create
    @new_article = Article.new(params[:article])
    
    if @new_article.save
      redirect_to(article_path(@new_article.id))
    else
      @article = Article.new(params[:article])
      render :new
    end
  end
  
  def new
    @article = Article.new()
  end
  
  def edit
    @article = Article.find(params[:id])
  end
  
  def show
    @article = Article.find(params[:id])
    @content = @article.updates.last.content
  end
  
  def update
    @new_article = Article.find(params[:id])
    
    if @new_article.update_attributes(params[:article])
      redirect_to(article_path(params[:id]))
    else
      @article = Article.find(params[:id])
      render :edit
    end
  end
  
  def destroy
    Article.delete(params[:id])
    redirect_to(articles_path)
  end
end
