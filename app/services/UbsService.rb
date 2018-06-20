class UbsService
  def self.find(latitude, longitude, page, per_page)
    Ubs.within(latitude, longitude).page(page).per(per_page)
  end
end
