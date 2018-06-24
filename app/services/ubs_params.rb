class UbsParams
  attr_reader :latitude, :longitude, :page, :per_page

  def initialize(params)
    @params = params
    @latitude, @longitude = @params[:query].split(",").tap { |p| raise ArgumentError, p unless p.size == 2 }
    @page = @params[:page]
    @per_page = @params[:per_page]
  end
end
