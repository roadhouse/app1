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
