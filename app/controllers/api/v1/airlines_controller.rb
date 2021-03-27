module Api
    module V1
        class AirlinesController < ApplicationController
                  # GET /api/v1/airlines
            def index
                render json: serializer(airlines, options)
            end
      
            # GET /api/v1/airlines/:slug
            def show
                render json: serializer(airline, options)
            end

            # POST /api/v1/airlines
            def create
                airline = Airline.new(airline_params)

                if airline.save
                render json: serializer(airline)
                else
                render json: errors(airline), status: 422
                end
            end

            # PATCH /api/v1/airlines/:slug
            def update
                airline = Airline.find_by(slug: params[:slug])

                if airline.update(airline_params)
                render json: serializer(airline, options)
                else
                render json: errors(airline), status: 422
                end
            end

            # DELETE /api/v1/airlines/:slug
            def destroy
                if airline.destroy
                head :no_content
                else
                render json: errors(airline), status: 422
                end
            end

            private

            def airline_params
                params.require(:airline).permit(:name, :image_url)
            end

            # Used For compound documents with fast_jsonapi
            def options
                @options ||= { include: %i[reviews] }
            end
        end
    end
end