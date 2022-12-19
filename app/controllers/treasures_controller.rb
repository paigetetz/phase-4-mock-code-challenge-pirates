class TreasuresController < ApplicationController


    def create
        treasure = Treasure.create(treasure_params)
        if treasure.valid?
            render json: treasure, status: :created, serializer: TreasureCreateSerializer
        else
            render json:{'errors': treasure.errors.full_messages}, status: :unprocessable_entity

        end
    end

    private

    def treasure_params
        params.permit(:contents, :pirate_id, :island_id)
    end
end
