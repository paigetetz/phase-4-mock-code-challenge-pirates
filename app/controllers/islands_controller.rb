class IslandsController < ApplicationController

    def index
        render json: Island.all
    end
end
