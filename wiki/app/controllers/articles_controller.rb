class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
  
  def create
    new_article = Article.new()
    
    if new_article.save
      redirect_to(article_path(add_underscore(new_article.title))
    else
      render :new
    end
  end
  
  def new
  end
  
  def edit
    @article = Article.find_by_title(add_spaces(params[:title]))
  end
  
  def show
    @article = Article.find_by_title(add_spaces(params[:title]))
  end
  
  def update
  end
  
  def destroy
  end
end
