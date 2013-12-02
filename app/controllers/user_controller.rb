class UserController < ApplicationController
  before_action :check_rights, only: [:admin, :change, :delete]

  def show
    @user = User.find(params[:id])
    @creatives = Creative.where(:user_id => params[:id]).paginate(:page => params[:page])
  end

  def admin
    @users = User.order(:username).paginate(:page => params[:page])
  end

  def change
    redirect_to admin_path
  end

  def delete
    user = User.find(params[:id])
    user.destroy
    redirect_to admin_path
  end

  private
    def check_rights
      authorize! :manage, current_user
    end
end
