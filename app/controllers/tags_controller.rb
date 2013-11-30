class TagsController < ApplicationController

  def start_with
    @tags = Tag.where("value LIKE ? ", "%#{params[:q]}%").sort_by{|e| -e[:ammount]}.take(10)
  end
  
end
