require 'rails_helper'

RSpec.describe ParkingLot, type: :model do
  it 'vlidates uniqueness of car_park_no' do
    create(:parking_lot, car_park_no: 'NUM')
    expect(build(:parking_lot, car_park_no: 'NUM')).not_to be_valid
  end
end
