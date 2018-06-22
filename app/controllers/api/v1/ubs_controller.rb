class UbsFinderService
  def initialize(params, radius)
    @params = UbsParams.new(params)

    @radius = radius
  end

  def self.ubs(params, radius = 100)
    new(params, radius).ubs
  end

  def ubs
    Ubs
      .within(@params.latitude, @params.longitude, @radius)
      .page(@params.page)
      .per(@params.per_page)
  end
end

class UbsParams
  attr_reader :latitude, :longitude, :page, :per_page

  def initialize(params)
    @params = params
    @latitude, @longitude = @params[:query].split(",").tap { |p| raise ArgumentError, p unless p.size == 2 }
    @page = @params[:page]
    @page = @params[:per_page]
  end
end

module Api
  module V1
    class UbsController < ApplicationController
      def find_ubs
        render json: UbsFinderService.ubs(find_params).to_json
      end

      private

      def find_params
        params.permit(:query,:page, :per_page)
      end
    end
  end
end
