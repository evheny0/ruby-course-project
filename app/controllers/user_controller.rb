class UserController < ApplicationController
  def show
    @creatives = Creative.where(:user_id => params[:id]).paginate(:page => params[:page])
  end
end
