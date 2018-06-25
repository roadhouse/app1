module Api
  module V1
    class UbsController < ApplicationController
      rescue_from StandardError, with: :render_error
      def find_ubs
        render json: UbsFinderService.ubs(find_params).to_json
      end

      private

      def find_params
        params.permit(:query, :page, :per_page)
      end

      def render_error
        Rails.logger.warn( "erro ")
        render status:500, json: {erro: "erro no servidor"}.to_json
      end
    end
  end
end
