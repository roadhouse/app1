module Api
  module V1
    class UbsController < ApplicationController
      def find_ubs
        render json: UbsFinderService.ubs(find_params).to_json
      end

      private

      def find_params
        params.permit(:query, :page, :per_page)
      end
    end
  end
end
