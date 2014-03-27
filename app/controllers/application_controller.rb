class ApplicationController < ActionController::Base
  protect_from_forgery
  

  def authorize
    if current_user.nil?
      redirect_to :new_login
    end
  end
  
  def admin
    if !current_user.admin
      redirect_to :articles
    end
  end
  
  def revoke
    if current_user && current_user.inactive
      session[:user_id] = nil
      redirect_to :root
    end
  end
    
  private
  
  # Return either `nil` or a User object.
  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end
  helper_method :current_user
  
  
  helper_method :markdown
  
  def markdown(text)
    options = {
      filter_html:     true,
      hard_wrap:       true, 
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true, 
      fenced_code_blocks: true
    }
 
    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }
 
    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)
 
    markdown.render(text).html_safe
  end
end
