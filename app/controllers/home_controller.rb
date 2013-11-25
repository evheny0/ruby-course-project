class HomeController < ApplicationController
  def index
    #I18n.locale = :ru
    @creatives = Creative.all
    @tags = Tag.all
    @users = User.all
  end
end
