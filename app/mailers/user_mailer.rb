class UserMailer < ActionMailer::Base
  default from: "ocs@livewirets.com"
  
  def confirm_email(user)
    @user = user
    @url = "http://" + ENV["APP_URL"] + "/users/confirm/" + @user.confirm_key
    
    mail(:to => @user.email, :subject => "Welcome to Omaha Code School Wiki")
  end
end
