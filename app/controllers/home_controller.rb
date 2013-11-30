class HomeController < ApplicationController
  def index
    # includes
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
    redirect_to root_path  #how to reload layout?
  end

end
