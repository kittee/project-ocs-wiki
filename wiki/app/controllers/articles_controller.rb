class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
  
  def create
    @article = Article.new({:title => params[:title]})
    @update = Update.new({:article_id => nil, :user_id => params[:user_id].to_i, :content => params[:content]})
    
    if @article.valid?
      @update.article_id = @article.id
      if @update.valid?
        @article.save
        @update.save
        redirect_to(article_path(@article.id))
      else
        render :new
      end
    else
      @update.valid?
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
