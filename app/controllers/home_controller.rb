class HomeController < ApplicationController
  def index
    #I18n.locale = :ru
    @users = User.all
  end
end
