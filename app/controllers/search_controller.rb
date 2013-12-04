class SearchController < ApplicationController

  def tag
    @param = params[:q]
    tag = Tag.where(:value => params[:q]).first
    @creatives = tag.creatives.paginate(:page => params[:page])
  end

  def text
    @creatives = Creative.search(params[:q], :page => params[:page], :per_page => 7)
  end

end
