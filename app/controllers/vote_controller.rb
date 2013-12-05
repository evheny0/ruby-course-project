class VoteController < ApplicationController
  before_action :set_vote_and_creative

  def change_vote
    if @creative
      if !@vote
        create_new_vote
        @vote_is_set = "true"
      else
        destroy_vote
      end
    end
    @vote_is_set ||= "false"
  end

  private
    def set_vote_and_creative
      @vote = Vote.where(:creative_id => params[:id], :user_id => current_user.id).first
      @creative = Creative.where(:id => params[:id]).first
    end

    def create_new_vote
      vote = Vote.create(:user_id => current_user.id, :creative_id => params[:id])
      vote.save
      @creative.num_of_votes += 1
      @creative.save
    end

    def destroy_vote
      @vote.destroy
      @creative.num_of_votes -= 1
      @creative.save
    end
end
