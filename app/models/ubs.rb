class Ubs < ApplicationRecord
  scope :within, -> (latitude, longitude, distance_in_km = 1) do
    where(%{ST_Distance(coordinates, 'POINT(%f %f)') < %d} % [longitude, latitude, distance_in_km * 1000])
  end
end
