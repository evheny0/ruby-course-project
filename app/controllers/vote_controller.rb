class VoteController < ApplicationController
  respond_to :json

  def change_vote
    vote = Vote.where(:creative_id => params[:id], :user_id => current_user.id).first
    creative = Creative.where(:id => params[:id]).first
    @qq = "false"
    if creative
      if !vote
        vote = Vote.create(:user_id => current_user.id, :creative_id => params[:id])
        vote.save
        creative.votes += 1
        creative.save
        @qq = "true"
      else
        vote.destroy
        creative.votes -= 1
        creative.save
        @qq = "false"
      end
    end
    render json: @qq
  end

end
