class HomeController < ApplicationController
  def index
    @creatives = Creative.order(:num_of_votes => :desc).paginate(:page => params[:page], :per_page => 7)
    @tags = Tag.most_popular
    @users = User.most_popular
  end

  def switch_theme
    if cookies[:theme] == "flatly"
        cookies[:theme] = "cyborg"
    else
        cookies[:theme] = "flatly"
    end
    redirect_to request.referrer
  end

end
