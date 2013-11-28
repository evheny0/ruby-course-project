class TagsController < ApplicationController

  def start_with
    @tags = Tag.where("value LIKE ? ", "%#{params[:q]}%").all
  end
  
end
