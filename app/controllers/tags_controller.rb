class TagsController < ApplicationController

  def start_with
    @tags = Tag.like(params[:q])
  end
  
end
