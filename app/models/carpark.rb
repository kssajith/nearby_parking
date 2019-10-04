class Carpark < ApplicationRecord
  acts_as_mappable :default_units => :miles,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude

  validates_uniqueness_of :car_park_no, case_sensitive: true

  scope :with_available_lot, -> { where("lots_available > ?", 0) }

  enum car_park_type: {
    'BASEMENT CAR PARK' => 0,
    'COVERED CAR PARK' => 1,
    'MECHANISED AND SURFACE CAR PARK' => 2,
    'MECHANISED CAR PARK' => 3,
    'MULTI-STOREY CAR PARK' => 4,
    'SURFACE CAR PARK' => 5,
    'SURFACE/MULTI-STOREY CAR PARK' => 6
  }

  enum type_of_parking_system: {
    'COUPON PARKING' => 0,
    'ELECTRONIC PARKING' => 1
  }

  enum night_parking: {
    'NO' => 0,
    'YES' => 1
  }

  enum car_park_basement: {
    'N' => 0,
    'Y' => 1
  }

  def self.nearest(params)

  end
end
