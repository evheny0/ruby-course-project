class VoteController < ApplicationController
  respond_to :json
  before_action :set_vote_with_creative

  def change_vote
    @response = "false"
    if @creative
      if !@vote
        vote = Vote.create(:user_id => current_user.id, :creative_id => params[:id])
        vote.save
        @creative.votes += 1
        @creative.save
        @response = "true"
      else
        @vote.destroy
        @creative.votes -= 1
        @creative.save
        @response = "false"
      end
    end
    @response
  end

  private
    def set_vote_with_creative
      @vote = Vote.where(:creative_id => params[:id], :user_id => current_user.id).first
      @creative = Creative.where(:id => params[:id]).first
    end
end
