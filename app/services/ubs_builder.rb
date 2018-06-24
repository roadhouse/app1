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
