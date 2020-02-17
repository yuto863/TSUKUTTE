module ApplicationHelper
  require "uri"

  def shape_create_time(created_at)
    if Post.where('created_at > ?', 1.year.ago)
      created_at.strftime("%m月%d日 %H:%M")
    else
      created_at.strftime("%Y年%m月%d日 %H:%M")
    end
  end
  
  # created_at.strftime("%Y年%m月%d日 %H:%M:%S")
  
  def text_url_to_link(text)
    URI.extract(text, ["http", "https"]).uniq.each do |url|
      text.gsub!(url, "<a href=\"#{url}\"target=\"_blank\">#{url}<\/a>")
    end
    text
  end
  
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
  def log_in(user)
    session[:user_id] = user.id
  end
  
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  
  
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  
  def logged_in?
    !current_user.nil?
  end
  
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
  
  
  def redirect_back_or_to(default)
    redirect_to(session[:forwarding_url] || default )
    session.delete(:forwarding_url)
  end
  
  def store_location
    session[:forwarding_url] = request.original_url
  end
  
  
 
  
  
end
