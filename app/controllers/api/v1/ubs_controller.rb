module Api
  module V1
    class UbsController < ApplicationController
      def find_ubs
        latitude, longitude = params[:query].split(",")

        render json: Ubs.within(latitude, longitude, 100).to_json
      end
    end
  end
end
