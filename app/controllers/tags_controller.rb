class TagsController < ApplicationController

  def start_with
    @tags = Tag.where("value LIKE ? ", "%#{params[:q]}%").order(:ammount).take(10)
  end
  
end
