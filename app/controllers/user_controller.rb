class UserController < ApplicationController
  before_action :check_rights, only: [:admin, :change, :delete]
  before_action :set_user, only: [:update, :delete]

  def show
    @user = User.find(params[:id])
    @creatives = get_creative
  end

  def admin
    @users = User.order(:username).paginate(:page => params[:page])
  end

  def update
    @user.update(user_params)
    if params[:confirm]
      user.update(:confirmed_at => Time.now)
    end
    redirect_to admin_path
  end

  def delete
    user.destroy
    redirect_to admin_path
  end

  private
    def check_rights
      authorize! :manage, current_user
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:admin)
    end

    def get_creative
      Creative.where(:user_id => params[:id]).paginate(:page => params[:page])
    end
end
