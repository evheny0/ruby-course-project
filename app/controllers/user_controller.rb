class UserController < ApplicationController
  def show
    @user = User.find(params[:id])
    @creatives = Creative.where(:user_id => params[:id]).paginate(:page => params[:page])
  end
end
