require 'csv'

namespace :import do
  desc 'import ubs data'
  task ubs: :environment do
    CSV
      .read("db/ubs.csv", headers: true, header_converters: :symbol)
      .map { |r| r.to_h }
      .map { |r| {coordinates: "POINT(#{r.delete(:vlr_longitude)} #{r.delete(:vlr_latitude)})"}.merge(r) }
      .map { |r| Ubs.create! r }
      .tap { |c| p "Total created: #{c.size}" }
  end
end
