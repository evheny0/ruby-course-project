class HomeController < ApplicationController
  def index
    #I18n.locale = :ru
    @creatives = Creative.paginate(:page => params[:page], :per_page => 10)
    @tags = Tag.all
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
