class HomeController < ApplicationController
  def index
    #I18n.locale = :ru
    @creatives = Creative.paginate(:page => params[:page], :per_page => 10)
    @tags = Tag.all
    @users = User.all

  end
end
