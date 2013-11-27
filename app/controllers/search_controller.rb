class SearchController < ApplicationController

    def index
        @param = params[:tag]
    end
end
