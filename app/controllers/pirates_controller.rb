class PiratesController < ApplicationController

    def index
        render json: Pirate.all
    end

    def show
        pirate = Pirate.find_by_id(params[:id])
        if pirate
            render json: pirate, status: :ok, serializer: PirateShowSerializer
        else
            render json: {error: 'Pirate not found'}, status: :not_found
        end
    end

    def destroy
        pirate = Pirate.find_by_id(params[:id])
        if pirate
            pirate.destroy
            head :no_content
        else
            render json: {error: 'Pirate not found'}, status: :not_found
        end
    end
end
