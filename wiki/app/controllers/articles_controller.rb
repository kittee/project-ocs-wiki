class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
  
  def create
    @article = Article.new({:title => params[:title]})
    @update = Update.new({:article_id => nil, :user_id => params[:user_id].to_i, :content => params[:content]})
    
    if ([@article, @update].map(&:valid?)).all?
      @article.save
      @update.article_id = @article.id
      @update.save
      redirect_to(article_path(@article.id))
    else
      render :new
    end
  end
  
  def new
    @article = Article.new()
    @update = Update.new()
  end
  
  def edit
    @article = Article.find(params[:id])
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
