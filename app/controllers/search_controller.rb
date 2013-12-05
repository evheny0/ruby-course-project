class SearchController < ApplicationController

  def tag
    @tag_value = params[:q]
    @creatives = get_creatives_by_tag
  end

  def text
    @creatives = Creative.search(params[:q], :page => params[:page])
  end

  private
    def get_creatives_by_tag
      seeking_tag = Tag.find_by(:value => @tag_value)
      seeking_tag.creatives.paginate(:page => params[:page]) if seeking_tag
    end
end
