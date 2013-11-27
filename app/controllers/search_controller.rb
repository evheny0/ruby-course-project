class SearchController < ApplicationController

    def index
        @param = params[:q]
        tag = Tag.where(:value => params[:q]).first
        @creatives = tag.creatives.paginate(:page => params[:page])
    end
end
