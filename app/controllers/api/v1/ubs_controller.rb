class UbsBuilder
  LEVELS = {
    "Desempenho mediano ou  um pouco abaixo da média" => 1,
    "Desempenho acima da média" => 2,
    "Desempenho muito acima da média" => 3
  }

  def initialize(params)
    @count = params.fetch(:count)
    @collection = params.fetch(:collection)
    @current_page = params.fetch(:current_page)
    @per_page = params.fetch(:per_page)
  end

  def self.build(args)
     UbsBuilder.new(args).serialize
  end

  def serialize_collection
    @collection.map do |ubs|
      {
        id: ubs.id,
        name: ubs.nom_estab,
        address: ubs.dsc_endereco,
        city: ubs.dsc_cidade,
        phone: ubs.dsc_telefone,
        geocode: {
          lat: ubs.coordinates.latitude,
          long: ubs.coordinates.longitude,
        },
        scores: {
          size: LEVELS.fetch(ubs.dsc_estrut_fisic_ambiencia, "invalid"),
          adaptation_for_seniors: LEVELS.fetch(ubs.dsc_adap_defic_fisic_idosos, "invalid"),
          medical_equipment: LEVELS.fetch(ubs.dsc_equipamentos, "invalid"),
          medicine: LEVELS.fetch(ubs.dsc_medicamentos, "invalid")
        }
      }
    end
  end

  def serialize
    {
      current_page: @current_page,
      per_page: @per_page,
      total_entries: @count,
      entries: serialize_collection
    }
  end
end

class UbsFinderService
  def initialize(params, radius)
    @params = UbsParams.new(params)

    @radius = radius
    @builder = UbsBuilder
  end

  def self.ubs(params, radius = 100)
    new(params, radius).ubs
  end

  def ubs
    serialize query
  end

  def serialize(query)
    @builder.build builder_data(query)
  end

  def builder_data(collection)
    {
      current_page: @params.page,
      per_page: @params.per_page,
      count: count,
      collection: query
    }
  end

  private

  def query
    Ubs
      .within(@params.latitude, @params.longitude, @radius)
      .page(@params.page)
      .per(@params.per_page)
  end

  def count
    Ubs.count
  end
end

class UbsParams
  attr_reader :latitude, :longitude, :page, :per_page

  def initialize(params)
    @params = params
    @latitude, @longitude = @params[:query].split(",").tap { |p| raise ArgumentError, p unless p.size == 2 }
    @page = @params[:page]
    @per_page = @params[:per_page]
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
        params.permit(:query, :page, :per_page)
      end
    end
  end
end
