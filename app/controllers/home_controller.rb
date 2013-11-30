class HomeController < ApplicationController
  def index
    @creatives = Creative.paginate(:page => params[:page], :per_page => 7)
    @tags = Tag.all.sort_by{|e| -e[:ammount]}.take(10)
    @users = User.all
  end

  def switch_theme
    if !cookies[:theme] || (cookies[:theme] == "flatly")
        cookies[:theme] = "cyborg"
    else
        cookies[:theme] = "flatly"
    end
    render :layout => "application"
    redirect_to root_path  #how to reload layout?
  end

end
