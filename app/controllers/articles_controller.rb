class ArticlesController < ApplicationController
  before_filter :revoke

  def index
    if params[:search] != nil && params[:search].size > 0
      @title = "Results for '#{params[:search]}'"
      @articles = Article.where("title ILIKE ?", "%#{params[:search]}%").order('updated_at DESC')
    elsif params[:cat] != nil
      @title = "Category '#{params[:cat]}'"
      @articles = Category.find_by_name(params[:cat]).articles.order('updated_at DESC')
    else
      @title = "All Articles"
      @articles = Article.order('updated_at DESC')
    end
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
    @users = []
    @article.updates.each do |u|
      @users << u.user.username
    end
    @users.uniq!
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
