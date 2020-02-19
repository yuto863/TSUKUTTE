class HomeController < ApplicationController
  def top
    if logged_in?
      redirect_to posts_daily_path
      
      # renderできない（パラメーターを渡せない）
      # render "posts/posts_trend_day"
    end
  end

end
